//
//  PhotosTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 15.12.2021.
//

import UIKit
import SDWebImage
import RealmSwift

class PhotosTableViewController: UITableViewController {
    
    private var photosApi = PhotosApi()
    private var photosDB = PhotosDB()
    private var photos: Results<PhotosDAO>?
    private var token: NotificationToken?
    private var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        
        //    photosDB.deleteAll()
        
        photosApi.getPhotos { [weak self] photos in
            
            guard let self = self else { return }
            
            //            self.photos = photos
            
            self.photosDB.save(photos)
            self.photos = self.photosDB.fetch()
            
            self.token = self.photos?.observe(on: .main, { [weak self] changes in
                guard let self = self else { return }
                
                switch changes {
                
                case .initial: self.tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({IndexPath(row: $0, section: $0)}), with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({IndexPath(row: $0, section: $0)}), with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({IndexPath(row: $0, section: $0)}), with: .automatic)
                    self.tableView.endUpdates()
                    
                case .error(let error):
                    print("An error occurred: \(error)")
                }
            })
            //            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let photos = photos else { return 0 }
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
        
        if let photo = photos?[indexPath.row] {
            //        var content = cell.defaultContentConfiguration()
            cell.textLabel?.text = String(photo.id)
            
            if let url = URL(string: photo.sizes.first!.url) {
                
                cell.imageView?.sd_setImage(with: url) { (image, _, _, _) in
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                    //            DispatchQueue.global().async { [weak self] in
                    //                do {
                    //                    let imageData = try Data(contentsOf: url)
                    //                    DispatchQueue.main.async {
                    //                        self!.imageView.image = UIImage(data: imageData)}
                    //                    print("Адрес картинки: \(url)")
                    //                } catch {
                    //                    print(error.localizedDescription)
                }
            }
        }
        //
        //        content.text = String(photo.id)
        //        content.image = imageView.image
        //        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        //
        //        cell.contentConfiguration = content
        
        return cell
    }
}

