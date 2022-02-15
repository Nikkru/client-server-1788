//
//  HashService.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 08.02.2022.
//

import UIKit
import Alamofire

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

class PhotoService {
    
    // задали константу, она будет определять время в секундах, в течение которого кеш считается актуальным. Обратите внимание на стиль, которым она задана. Это умножение чисел — дней, часов, минут и секунд.
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    //        cтатическое свойство, имя папки, в которой будут сохраняться изображения. Свойство инициируется с помощью замыкания. Помимо этого, в замыкании происходит проверка, существует ли папка. Если не существует, она будет создана.
    private static let pathName: String = {
        
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    private let container: DataReloadable
    
    //           Для перезагрузки необходима ссылка на объект таблицы или коллекции, и здесь нас подстерегает первая сложность: у таблицы и коллекции разные классы и методы обновления элемента. Для унифицирования обновления мы создадим протокол и два объекта, в которые обернём коллекцию и таблицу.
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    //словарь в котором будут храниться загруженные и извлеченные из файловой системы изображения. Это кеш в оперативной памяти с минимальным временем доступа, специально для таблиц и коллекций, где очень важна скорость получения изображений
    private var images = [String: UIImage]()
    
    //     получает на вход URL изображения и возвращает на его основе путь к файлу для сохранения или загрузки. Обратите внимание, имя для файла мы получаем на основе его URL, который чаще всего будет ссылкой на этот файл в сети Internet. Таким образом, имя файла будет совпадать с тем, что на сервере.
    
    private func getFilePath(url: String) -> String? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    //    сохраняет изображение в файловой системе
    private func saveImageToCache(url: String, image: UIImage) {
        
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    //    загружает изображение из файловой системы. При этом он проводит ряд проверок. Первым делом мы пытаемся получить атрибуты изображения FileManager.default.attributesOfItem. Этот метод вернёт всю техническую информацию о файле, если он существует. Нас интересует дата последнего изменения. Если со времени изменения файла прошло больше секунд, чем указано в нашем свойстве cacheLifeTime, файл считается устаревшем и мы не будем заново загружать его из сети.
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
    
    //    загружает фото из сети. Это обычный Alamofire-запрос на получение данных, он проходит в глобальной очереди, загружает изображение, сохраняет его на диске и в словаре images. Кроме того, после окончания загрузки он обновляет строку в таблице, чтобы отобразить загруженное изображение.
    
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath)
            }
        }
    }
    
    //Метод photo предоставляет изображение по URL. При этом мы ищем изображение сначала в кеше оперативной памяти, потом в файловой системе; если его нигде нет, загружаем из сети. IndexPath требуется, чтобы установить загруженное изображение в нужной строке, а не в ячейке, которая в момент, когда загрузка завершится, может быть использована для совершенно другой строки.
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }
}

extension PhotoService {
    
    //    Table — первый класс, имплементирующий протокол DataReloadable. В него будет заворачиваться UITableView. Класс достаточно простой, у него есть свойство для хранения ссылки на таблицу и конструктор, принимающий эту таблицу. Самое важное — реализация метода reloadRow, он вызывает обновление строки в таблице.
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    //       Класс Collection аналогичен классу Table, с той лишь разницей, что он хранит ссылку на экземпляр UICollectioView и обновляет её элементы.
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
