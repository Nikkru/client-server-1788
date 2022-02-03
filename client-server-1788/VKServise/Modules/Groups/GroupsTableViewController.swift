//
//  GroupsTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 19.12.2021.
//

import UIKit
import SDWebImage
import RealmSwift
import Firebase

class GroupsTableViewController: UITableViewController {
    
    private var groupsApi = GroupsApi()
    private var groupsdDB = GroupsDB()
    private var groups: Results<GroupsDAO>?
    private var groupsDAO: [GroupsDAO] = []
    private var token: NotificationToken?
    
    let ref = Database.database().reference()
    var groupsFB: [GroupFB] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //        удаляем страрые группы
        groups = groupsdDB.fetch()
        groupsdDB.delete(groups!)
        
        groupsApi.getGroups { [weak self] groups in
            guard let self = self else { return }
            
            //            save list of groups
            self.groupsdDB.save(groups)
            //            load list of groups
            self.groups = self.groupsdDB.fetch()
            
            //            automatic reload table by change BD in Realm
            self.token = self.groups?.observe(on: .main, { [weak self] changes in
                
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
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let groups = groups else { return 0}
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let group = groups?[indexPath.row] {
            
            cell.textLabel?.text = group.name
            
            if let url = URL(string: group.photo100) {
                cell.imageView?.sd_setImage(with: url, completed: { (image, _, _, _) in
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                })
            }
        }
        addGroupsInFB(groups: groups, token: Session.shared.token, indexPath: indexPath)
        return cell
    }
}

// MARK: - upload to Firebase database
extension GroupsTableViewController {
    
    func addGroupsInFB(groups: Results<GroupsDAO>?, token: String, indexPath: IndexPath) {
        
        guard let groupsDB = groups else { return }
        
        let group = GroupFB(id: groupsDB[indexPath.row].id,
                            name: groupsDB[indexPath.row].name,
                            screenName: groupsDB[indexPath.row].screenName,
                            photo100: groupsDB[indexPath.row].photo100,
                            photo50: groupsDB[indexPath.row].photo50,
                            type: groupsDB[indexPath.row].type,
                            isClosed: groupsDB[indexPath.row].isClosed)
        
        let groupContainerRef = self.ref.child("session: \(token)").child("groups").child(String(group.id))
        groupContainerRef.setValue(group.toAnyObject())
    }
}
