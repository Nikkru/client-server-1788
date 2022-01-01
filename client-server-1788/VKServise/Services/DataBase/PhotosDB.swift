//
//  PhotosDB.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 01.01.2022.
//

import Foundation
import RealmSwift

// MARK: - Model for storage
class PhotosDAO: Object, Codable {
    
    @Persisted var text: String?
    @Persisted var id = 0
    @Persisted var date = 0
    @Persisted var postID = 0
    @Persisted var sizes: List<SizeDAO>
    @Persisted var ownerID = 0
    
    let lat: Double = 0
    let long: Double = 0
    let albumID: Int
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text, lat, sizes
        case ownerID = "owner_id"
        case long
    }
}
class SizeDAO: Object, Codable {

    @Persisted var url: String = ""
    @Persisted var type: String = ""
    
    let width: Int
    let height: Int
}

final class PhotosDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 4)
    }
    
    
    func save(_ items: [PhotosDAO]) {
        
//        Если в каждом методе ижет свой Realm, можно создавать объект ассинхронно через try!
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
        guard  let url = realm.configuration.fileURL else { return }
        print(url)
    }
    
    func fetch() -> Results<PhotosDAO> {
        let realm = try! Realm()
        
        let friends: Results<PhotosDAO> = realm.objects(PhotosDAO.self)
        return friends
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write{
            realm.deleteAll()
        }
    }
    
    func delete(_ item: PhotosDAO) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
    }
}
