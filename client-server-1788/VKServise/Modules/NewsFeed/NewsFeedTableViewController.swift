//
//  NewsFeedTableViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 26.01.2022.
//

import UIKit
import SDWebImage

enum NewsCellType: Int, CaseIterable {
    case text = 0
    case photo
    case autor
    case likeCount
}

class NewsFeedTableViewController: UITableViewController {
    
    private var newsApi = NewsApi()
    private var newsfeeds = NNewsFeed(response: .init(
                                        items: [],
                                        profiles: [],
                                        groups: []))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        newsApi.getNews { [weak self] feed in
//    
//            guard let self = self else { return }
//            
//            self.newsfeeds = feed!
//            
//            print("")
//            print ("\(self.newsfeeds.response.items)")
//        }
//        
//        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
 
//        return news.count
        return newsfeeds.response.items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NewsCellType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = newsfeeds.response.items[indexPath.section]
        let profile = newsfeeds.response.profiles[indexPath.section]
//        let group = newsfeeds.response.groups[indexPath.section]
        
        let newsCellType = NewsCellType(rawValue: indexPath.row)
        
        var returnCell: UITableViewCell!
        
        switch newsCellType {
        case .text:
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "TextNewsFeedCell",
                for: indexPath
            ) as? TextNewsFeedCell else { return returnCell }
            
            cell.config(text: "\(item.text)")
            
            returnCell = cell
            
        case .photo:
            
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "PhotoNewsFeedCell",
                    for: indexPath
            ) as? PhotoNewsFeedCell else { return returnCell }
            
//            cell.photoFeedImageView.image = UIImage(named: new.photo ?? "heart.fill")
            cell.config(urlAuthorPhoto: "\(item.attachments[indexPath.row].photo?.sizes[indexPath.row].url)")
            returnCell = cell
            
        case .autor:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorNewFeedCell", for: indexPath) as? AuthorNewFeedCell else { return returnCell }
            
            cell.config(authorName: "\(profile.firstName) \(profile.lastName)", authorAvatar: profile.photo100!, dateNews: String(item.date))
            
            returnCell = cell
            
        case .likeCount:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LikeNewsFeedCell", for: indexPath) as? LikeNewsFeedCell else { return returnCell }
            
            cell.config(countLikes: item.likes.count, countComments: item.comments.count, countShared: item.reposts.count)
            
            returnCell = cell
            
        default:
            return UITableViewCell()
        }
        
        return returnCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        let new = news[indexPath.section]
        
        var height: CGFloat!
        
        let item = newsfeeds.response.items[indexPath.section]

        let newsCellType = NewsCellType(rawValue: indexPath.row)
        
        switch newsCellType {
        
        case .text:
            
            if item.text == "" {
                height = 0.0
            } else { height = 80.0 }
            
        case .photo:
            
            if item.attachments[indexPath.row].photo?.sizes[indexPath.row].url == "" {
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
