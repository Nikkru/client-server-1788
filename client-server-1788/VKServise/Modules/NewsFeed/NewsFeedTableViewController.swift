//
//  NewsFeedTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 26.01.2022.
//

import UIKit

enum NewsCellTipe: Int, CaseIterable {
    case autor = 0
    case text
    case photo
    case likeCount
}

class NewsFeedTableViewController: UITableViewController {
    
    private var new: New?
    private var news: [New] = []
    
    private var newsApi = NewsApi()
    //    private var newsfeeds: [NNewsFeed] = []
    private var newsfeeds = NNewsFeed(response: .init(
                                        items: [],
                                        profiles: [],
                                        groups: []))
    
    private var vkItemsArray: [NItem] = []
    private var vkProfilesArray: [NProfile] = []
    private var vkGroupsArray: [NGroup] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let new1 = New(date: 280222, text: "Hello, Friend!", comments: 10, likes: 12, reposts: 13, photo: "", author: "BBC", shared: 10)
        news.append(new1)
        let new2 = New(date: 280222, text: "", comments: 20, likes: 22, reposts: 23, photo: "fox", author: "FOX", shared: 14)
        news.append(new2)
        
        newsApi.getNews { [weak self] feed in
            guard let self = self else { return }
            
            guard let itemsArray = (feed?.response.items) else { return }
            self.vkItemsArray = itemsArray
            guard let profilesArray = (feed?.response.profiles) else { return }
            self.vkProfilesArray = profilesArray
            guard let groupsArray = (feed?.response.groups)  else { return }
            self.vkGroupsArray = groupsArray
            
        }
        
        tableView.reloadData()
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
        
//        let item = newsfeeds.response.items[indexPath.section]
//        let profile = newsfeeds.response.profiles[indexPath.section]
//        let group = newsfeeds.response.groups[indexPath.section]
        
        let newsCellType = NewsCellTipe(rawValue: indexPath.row)
        
        var returnCell: UITableViewCell!
        let new = news[indexPath.section]
        
        switch newsCellType {
        case .text:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextNewsFeedCell", for: indexPath) as? TextNewsFeedCell else { return returnCell }
            cell.textFeedLabel.text = new.text
            returnCell = cell
            
        case .photo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoNewsFeedCell", for: indexPath) as? PhotoNewsFeedCell else { return returnCell }
            cell.photoFeedImageView.image = UIImage(named: new.photo ?? "heart.fill")
            returnCell = cell
            
        case .autor:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorNewFeedCell", for: indexPath) as? AuthorNewFeedCell else { return returnCell }
            cell.authorNewsFeedLabel.text = new.author
            cell.authorImage.image = UIImage(named: new.photo ?? "heart")
            cell.dateNewsFeedLabel.text = String(new.date)
            returnCell = cell
            
        case .likeCount:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LikeNewsFeedCell", for: indexPath) as? LikeNewsFeedCell else { return returnCell }
            cell.CountLikeLabel.text = String(new.likes ?? 0)
            cell.CountCommentLabel.text = String(new.comments )
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
        let newsCellType = NewsCellTipe(rawValue: indexPath.row)
        
        switch newsCellType {
        case .text:
            if new.text == "" {
                height = 0.0
            } else { height = 80.0 }
        case .photo:
            if new.photo == "" {
                height = 0.0
            } else { height = 80.0 }
        case .autor:
            height = 44
        case .likeCount:
            height = 30
            
        default:
            break
        }

        return height
    }
    
}
