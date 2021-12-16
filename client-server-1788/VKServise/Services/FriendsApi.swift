//
//  FriendsApi.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 15.12.2021.
//

import UIKit
import Alamofire

// https://api.vk.com/method/users.get?user_id=210700286&v=5.52

final class FriendsApi {
    
    func getFriends(completion: @escaping([Friend])->()) {
        
        let baseUrl = "https://api.vk.com/method/"
        let token = Session.shared.token
        let userId = Session.shared.userId
        let version = "5.81"
        
        let method = "friends.get"
        let url = baseUrl + method
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "fields": "photo_50",
            "access_token": token,
            "count": 100,
            "v": version
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseJSON { response in
                    
//                    print(response.result)
                    print(response.data?.prettyJSON)
                    
                    guard let jsonData = response.data else { return }
                    
                    do {
                        let friendsContainer = try JSONDecoder().decode(FriendsContainer.self, from: jsonData)
                         let friends = friendsContainer.response.items
                        
                        completion(friends)
                    } catch {
                        print(error)
                    }
                    
                
                   }
    }
}
