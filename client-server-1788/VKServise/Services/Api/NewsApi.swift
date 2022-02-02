//
//  NewsApi.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 31.01.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NewsApi {
    
    func getNews(completion: @escaping(Feed?)->()) {
//        func getNews() {
        
        let baseUrl = "https://api.vk.com/method/"
        let token = Session.shared.token
        let userId = Session.shared.userId
        let version = "5.131"
        
        let method = "newsfeed.get"
        let url = baseUrl + method
        
        let parameters: Parameters = [
            "user_id": userId,
            "filters": "post, group, photo, wall_photo, note",
            "start_time": 1643529965,
            "access_token": token,
            "count": 2,
            "max_photos": 2,
            "v": version
        ]
        
        AF.request(
            url,
            method:  .get,
            parameters: parameters
        ).responseJSON { response in
            
            print("RESPONSE.DATA: \(String(describing: response.data?.prettyJSON))")

            guard let jsonData = response.data else { return }

            let decoder = JSONDecoder()
            let json = JSON(jsonData)
            let dispatchGroup = DispatchGroup()

            let vkItemsJSONArr = json["response"]["itemse"].arrayValue
            let vkProfilesJSONArr = json["response"]["profiles"].arrayValue
            let vkGroupsJSONArr = json["response"]["groups"].arrayValue

            var vkItemsArray: [Item] = []
            var vkProfilesArray: [Profile] = []
            var vkGroupsArray: [Group] = []

            DispatchQueue.global().async(group: dispatchGroup) {

                for (index, items) in vkItemsJSONArr.enumerated() {
                    do {
                        let decodeItem = try decoder.decode(Item.self, from: items.rawData())
                        vkItemsArray.append(decodeItem)
                    } catch(let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                print("items")
            }

            // decoding frofiles
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, profiles) in vkProfilesJSONArr.enumerated() {
                    do {
                        let decodeItem = try decoder.decode(Profile.self, from: profiles.rawData())
                        vkProfilesArray.append(decodeItem)
                    } catch(let errorDecode) {
                        print("Profile decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                print("profiles")
            }
            
            // decoding groups
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, groups) in vkGroupsJSONArr.enumerated() {
                    do {
                        let decodeItem = try decoder.decode(Group.self, from: groups.rawData())
                        vkGroupsArray.append(decodeItem)
                    } catch(let errorDecode) {
                        print("Group decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                print("groups")
            }

            dispatchGroup.notify(queue: DispatchQueue.main) {
                let response = NewsResponse(items: vkItemsArray,
                                            profiles: vkProfilesArray,
                                            groups: vkGroupsArray)
                let feed = Feed(response: response)
                
                completion(feed)
            }
        }
    }
}