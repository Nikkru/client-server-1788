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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        groupsApi.getGroups { [weak self] groups in
            guard let self = self else { return }
            
//            self.groups = groups
//            self.tableView.reloadData()
            
            self.groupsdDB.save(groups)
            self.groups = self.groupsdDB.fetch()
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
        }
        
        return cell
    }
}
