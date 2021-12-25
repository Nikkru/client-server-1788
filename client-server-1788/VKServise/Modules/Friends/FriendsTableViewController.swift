//
//  FriendsTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 15.12.2021.
//

import UIKit
import SDWebImage

final class FriendsTableViewController: UITableViewController {
    
    private var friendsApi = FriendsApi()
    private var friends = [FriendsDAO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        friendsApi.getFriends3 { [weak self] friends in
            
            guard let self = self else { return }
            
            self.friends = friends
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let friend: FriendsDAO = friends[indexPath.row]
        
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        
        if let url = URL(string: friend.photo100) {
            cell.imageView?.sd_setImage(with: url, completed: nil)
        }
        
        return cell
    }
}
