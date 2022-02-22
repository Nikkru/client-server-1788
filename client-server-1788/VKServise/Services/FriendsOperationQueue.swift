//
//  FriendsOperationQueue.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 12.02.2022.
//

import Foundation

class FriendsMakeApiDataOperation: Operation {
    
    var data: Data?
    
    override func main() {
        var requestConstructor = URLComponents()
        requestConstructor.scheme = "https"
        requestConstructor.host = "api.vk.com"
        requestConstructor.path = "/method/friends.get"
        requestConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_50, photo_100, online"),
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "v", value: "\(Session.shared.versionVK)")
        ]
        guard let url = requestConstructor.url else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        self.data = data
        print(data.prettyJSON!)
    }
}

class FriendsParsingOperation: Operation {
    
    var friendsList: [FriendsDAO]? = []
    
    override func main() {
        
        guard let friendsListData = dependencies.first as? FriendsMakeApiDataOperation,
              let data = friendsListData.data else { return }
        
        do {
            let responseData = try JSONDecoder().decode(Friends.self, from: data)
            self.friendsList = responseData.response.items
        } catch {
            print(error)
        }
    }
}

class FriendsDiaplayOperation: Operation {
    
    var friendsTableViewController: FriendsTableViewController
    override func main() {
        
        guard let parsFriendsListData = dependencies.first as? FriendsParsingOperation,
              let friendsList = parsFriendsListData.friendsList else { return }
        friendsTableViewController.friendArray = friendsList
        
    }
    
    init(controller: FriendsTableViewController) {
        self.friendsTableViewController = controller
    }
}
