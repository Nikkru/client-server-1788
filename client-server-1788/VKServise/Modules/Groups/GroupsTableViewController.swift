//
//  GroupsTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 19.12.2021.
//

import UIKit
import SDWebImage
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
    private var groupsApi = GroupsApi()
    private var groupsdDB = GroupsDB()
    private var groups: Results<GroupsDAO>?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        groupsApi.getGroups { [weak self] groups in
            guard let self = self else { return }
            
//            self.groups = groups
//            self.tableView.reloadData()
            
            self.groupsdDB.save(groups)
            self.groups = self.groupsdDB.fetch()
            
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
            
//            self.tableView.reloadData()
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
        
        return cell
    }
}
