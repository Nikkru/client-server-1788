//
//  PhotosTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 15.12.2021.
//

import UIKit
import SDWebImage

class PhotosTableViewController: UITableViewController {
    
    private var photosApi = PhotosApi()
    private var photos = [PhotoDTO]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PhotoCell")

        photosApi.getPhotos { [weak self] photos in
            
            guard let self = self else { return }
            
            self.photos = photos
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return photos.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)

        let photo: PhotoDTO = photos[indexPath.row]
        
        cell.textLabel?.text = String(photo.id)
        
        if let url = URL(string: photo.sizes.first!.url) {
            cell.imageView?.sd_setImage(with: url, completed: nil)
        }
        
        return cell
    }
}

