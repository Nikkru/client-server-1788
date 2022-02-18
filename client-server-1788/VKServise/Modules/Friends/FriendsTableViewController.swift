//
//  FriendsTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 15.12.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Firebase
import PromiseKit



final class FriendsTableViewController: UITableViewController {
    
    private var friendsApi = FriendsApi()
    
    var friendArray = [FriendsDAO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let operationQueue = OperationQueue()
        let friendsMakeApiDataOperation = FriendsMakeApiDataOperation()
        let friendsParsingOperation = FriendsParsingOperation()
        let friendsDisplayOperation = FriendsDiaplayOperation(controller: self)
        
        operationQueue.addOperation(friendsMakeApiDataOperation)
        friendsParsingOperation.addDependency(friendsMakeApiDataOperation)
        operationQueue.addOperation(friendsParsingOperation)
        friendsDisplayOperation.addDependency(friendsParsingOperation)
        OperationQueue.main.addOperation(friendsDisplayOperation)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return friendArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let friend = friendArray[indexPath.row]
        
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        
        if let url = URL(string: friend.photo100) {
            cell.imageView?.sd_setImage(with: url, completed:  { image, _, _, _ in
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        }
        
        return cell
    }
}

