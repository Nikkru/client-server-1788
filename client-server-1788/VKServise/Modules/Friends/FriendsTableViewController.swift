//
//  FriendsTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 15.12.2021.
//

import UIKit
import SDWebImage
import RealmSwift

final class FriendsTableViewController: UITableViewController {
    
    private var friendsApi = FriendsApi()
    private var friendsDB = FriendsDB()
    private var friends: Results<FriendsDAO>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        friendsApi.getFriends3 { [weak self] friends in
            guard let self = self else { return }
            
//            self.friends = friends
//            self.friendsDB.save(friends)
            self.friendsDB.save(friends)
            self.friends = self.friendsDB.fetch()
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        guard let friends = friends else { return 0 }
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let friend = friends?[indexPath.row] {
        
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        
            if let url = URL(string: friend.photo100) {
            cell.imageView?.sd_setImage(with: url, completed:  { image, _, _, _ in
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        }
        }
        return cell
    }
}
