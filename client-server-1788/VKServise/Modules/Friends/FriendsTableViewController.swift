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

final class FriendsTableViewController: UITableViewController {
    
    private var friendsApi = FriendsApi()
    private var friendsDB = FriendsDB()
    private var friends: Results<FriendsDAO>?
    private var token: NotificationToken?
    
    let ref = Database.database().reference()
    var friendsFB: [FriendFB] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        friendsDB.deleteAll()
        
        friendsApi.getFriends3 { [weak self] friends in
            
            guard let self = self else { return }
            
            self.friendsDB.save(friends)
            self.friends = self.friendsDB.fetch()
            
            self.token = self.friends?.observe(on: .main, { [weak self] changes in
                 
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
                     print(error)
                 }
             })
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
        addFriendsInFB(friends: friends, token: Session.shared.token, indexPath: indexPath)
        return cell
    }
}

// MARK: - upload to Firebase
extension FriendsTableViewController {
    
    func addFriendsInFB(friends: Results<FriendsDAO>?, token: String, indexPath: IndexPath) {
        
        guard let friendsDB = friends else { return }
        //        let friendFB: FriendFB?
        //        for i in friendsDB {
        //            let friend = FriendFB(id: i.id,
        //                                  firstName: i.firstName,
        //                                  lastName: i.lastName,
        //                                  photo100: i.photo100,
        //                                  photo50: i.photo50)
        ////            self.friendsFB.append(friend)
        //            let friendContainerRef = self.ref.child(token).child(String(friend.id))
        //            friendContainerRef.setValue(friend.toAnyObject())
        //        }
        let friend = FriendFB(id: friendsDB[indexPath.row].id,
                              firstName: friendsDB[indexPath.row].firstName,
                              lastName: friendsDB[indexPath.row].lastName,
                              photo100: friendsDB[indexPath.row].photo100,
                              photo50: friendsDB[indexPath.row].photo50)
        
        let friendContainerRef = self.ref.child("session: \(token)").child("friends").child(String(friend.id))
        friendContainerRef.setValue(friend.toAnyObject())
    }
}
