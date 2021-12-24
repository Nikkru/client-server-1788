//
//  GroupsApi.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 16.12.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

final class GroupsApi {
    
    func getGroups(completion: @escaping([GroupDAO])->()) {
        
        let baseUrl = "https://api.vk.com/method/"
        let token = Session.shared.token
        let userId = Session.shared.userId
        let version = "5.81"
        
        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "access_token": token,
            "count": 5,
            "v": version
        ]
        
        let method = "groups.get"
        let url = baseUrl + method
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseJSON { response in
                    
                    print("GROUPS RESPONSE.DATA: \(response.data?.prettyJSON)")
                    
                    guard let jsonData = response.data else { return }
                    do {
                        let itemsData = try JSON(jsonData)["response"]["items"].rawData()
                        let groups = try JSONDecoder().decode([GroupDAO].self, from: itemsData)
                        completion(groups)
                    } catch {
                        print(error)
                    }
                   }
    }
}


