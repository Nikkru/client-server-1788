//
//  NewsFeedTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 26.01.2022.
//

import UIKit

class NewsFeedTableViewController: UITableViewController {
    
    var new: New?
    private var news: [New] = []
    private var newsApi = NewsApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let new1 = New(date: 280222, text: "Hello, Friend!", comments: 10, likes: 12, reposts: 13, photo: "", author: "BBC", shared: 10)
        news.append(new1)
        let new2 = New(date: 280222, text: "", comments: 20, likes: 22, reposts: 23, photo: "fox", author: "FOX", shared: 14)
        news.append(new2)
        
//        newsApi.getNews()
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
        let new = news[indexPath.section]
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextNewsFeedCell", for: indexPath) as? TextNewsFeedCell else { return returnCell }
            cell.textFeedLabel.text = new.text
            returnCell = cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoNewsFeedCell", for: indexPath) as? PhotoNewsFeedCell else { return returnCell }
            cell.photoFeedImageView.image = UIImage(named: new.photo ?? "heart.fill")
            returnCell = cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorNewFeedCell", for: indexPath) as? AuthorNewFeedCell else { return returnCell }
            cell.AuthorFeedLabel.text = new.author
            cell.AuthorImge.image = UIImage(named: new.photo ?? "heart")
            cell.DateFeedLabel.text = String(new.date)
            returnCell = cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LikeNewsFeedCell", for: indexPath) as? LikeNewsFeedCell else { return returnCell }
            cell.CountLikeLabel.text = String(new.likes ?? 0)
            cell.CountCommentLabel.text = String(new.comments ?? 0)
            cell.CountSharedLabel.text = String(new.shared ?? 0)
            returnCell = cell
        default:
            break
        }
        
        return returnCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let new = news[indexPath.section]
        var height: CGFloat!
        
        switch indexPath.row {
        case 0:
            if new.text == "" {
                height = 0.0
            } else { height = 80.0 }
        case 1:
            if new.photo == "" {
                height = 0.0
            } else { height = 80.0 }
        case 2:
            height = 60
        case 3:
            height = 44
            
        default:
            break
        }

        return height
    }
    
}
