//
//  NewsFeedTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 26.01.2022.
//

import UIKit

class NewsFeedTableViewController: UITableViewController {

    var news = ["Donald", "Popeye", "Jerri", "Scrooge", "Eric Cartman", "Lisa Simpson"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TextNewsFeedCell")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PhotoNewsFeedCell")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AuthorNewsFeedCell")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LikeNewsFeedCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var returnCell: UITableViewCell!
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextNewsFeedCell", for: indexPath) as? TextNewsFeedCell else { return returnCell }
            cell.textFeedLabel.text = "0"
            returnCell = cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoNewsFeedCell", for: indexPath) as? PhotoNewsFeedCell else { return returnCell }
            cell.photoFeedImageView.image = UIImage(named: "heart.fill")
            returnCell = cell
          
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorNewsFeedCell", for: indexPath) as? AuthorNewsFeedCell else { return returnCell }
            cell.AuthorFeedLabel.text = " Гайдар"
            returnCell = cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LikeNewsFeedCell", for: indexPath) as? LikeNewsFeedCell else { return returnCell }
            cell.CountLikeLabel.text = "100"
            cell.CountCommentLabel.text = "100"
            returnCell = cell
        default:
            break
        }
//        if indexPath.row == 0 {
//
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextNewsFeedCell", for: indexPath) as? TextNewsFeedCell else { return returnCell }
//
//            cell.textFeedLabel.text = "0"
//
//            returnCell = cell
//        } else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorNewsFeedCell", for: indexPath) as? AuthorNewsFeedCell else { return returnCell }
//
//            cell.AuthorFeedLabel.text = " Гайдар"
//
//            returnCell = cell
//        }
        
        return returnCell
    }
    
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
