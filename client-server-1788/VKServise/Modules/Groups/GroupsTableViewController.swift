//
//  GroupsTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 19.12.2021.
//

import UIKit
import SDWebImage

class GroupsTableViewController: UITableViewController {
    
    private var groupsApi = GroupsApi()
    private var groups = [GroupDTO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GroupCell")
        
        groupsApi.getGroups { [weak self] groups in
            guard let self = self else { return }
            self.groups = groups
            self.tableView.reloadData()
        }
    }
//    groupsApi.getGroups { [weak self] groups in
//
//        guard let self = self else { return }
//
//        self.groups = groups
//        self.tableView.reloadData()
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
 
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        
        let group: GroupDTO = groups[indexPath.row]
        
        cell.textLabel?.text = group.screenName
        
        return cell
    }
}
