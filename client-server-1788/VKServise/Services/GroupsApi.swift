//
//  GroupsApi.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 16.12.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

private func getGroupsApi() {
    
    func getGroups(completion: @escaping([PhotoDTO])->()) {
    
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
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            print("RESPONSE.DATA: \(response.data?.prettyJSON)")
            
            guard let jsonData = response.data else { return }
            do {
                let itemsData = try JSON(jsonData)["response"]["items"].rawData()
            } catch {
                print(error)
            }
        }
    }
}
