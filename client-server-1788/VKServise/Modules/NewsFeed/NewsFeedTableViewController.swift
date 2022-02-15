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
    private var newsArray: [NewsModel] = []
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MM YYYY 'в' HH:mm"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        newsApi.getNews { NNewsFeed, _ in
            self.newsArray = NNewsFeed
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return NewsCellType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newsCellType = NewsCellType(rawValue: indexPath.row)
        var returnCell: UITableViewCell!
        
        switch newsCellType {
        
        case .text:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "TextNewsFeedCell", for: indexPath
            ) as? TextNewsFeedCell else { return returnCell }
            
            cell.config(text: newsArray[indexPath.section].text ?? "")
            
            returnCell = cell
            
        case .photo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "PhotoNewsFeedCell", for: indexPath
            ) as? PhotoNewsFeedCell else { return returnCell }
            
            let post = newsArray[indexPath.section]
            let photoUrl = post.photoSizes?.last?.url
            print("адрес фотографии \(String(describing: photoUrl))")
            
            cell.config(urlAuthorPhoto: photoUrl ?? "")
            returnCell = cell
            
        case .autor:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorNewFeedCell", for: indexPath) as? AuthorNewFeedCell else { return returnCell }
            
            cell.config(
                authorName: newsArray[indexPath.section].name,
                authorAvatar: newsArray[indexPath.section].photo100!,
                dateNews: dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(newsArray[indexPath.section].date!)))
            )
            
            returnCell = cell
            
        case .likeCount:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LikeNewsFeedCell", for: indexPath) as? LikeNewsFeedCell else { return returnCell }
            
            cell.config(countLikes: newsArray[indexPath.section].like ?? 0,
                        countComments: newsArray[indexPath.section].comments ?? 0,
                        countShared: newsArray[indexPath.section].reposts ?? 0)
            
            returnCell = cell
            
        default:
            return UITableViewCell()
        }
        
        return returnCell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat!
        
        let item = newsArray[indexPath.section]
        
        let newsCellType = NewsCellType(rawValue: indexPath.row)
        
        switch newsCellType {
        
        case .text:
            
            if item.text == nil {
                height = 0.0
            } else { height = UITableView.automaticDimension}
            
        case .photo:
            
            if item.photoSizes?.last?.url == nil {
                height = 0.0
            } else {
                
                height = CGFloat((item.photoSizes?.last?.height)!)
            }
            
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
