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
    
    func getNews(completion: @escaping([NewsModel], [NPhoto])->()) {
        
        let baseUrl = "https://api.vk.com/method/"
        let token = Session.shared.token
        let userId = Session.shared.userId
        let version = "5.131"
        
        let method = "newsfeed.get"
        let url = baseUrl + method
        
        let parameters: Parameters = [
            "user_id": userId,
            "filters": "post, photo, photo_tag, wall_photo, friend, note ,audio ,video",
            "start_time": 1643529965,
            "access_token": token,
            "return_banned":"1",
            "count": 100,
            "source_ids": "friends, groups, pages, following",
            "fields": "name, photo_100, first_name, last_name, photo_50",
            "max_photos": 5,
            "v": version
        ]
        
        AF.request(url,method: .get, parameters: parameters).responseJSON { response in
            
            print("RESPONSE.DATA FROM NEWSFEED: \(String(describing: response.data?.prettyJSON))")
            
            guard let jsonData = response.data else { return }
            
            let decoder = JSONDecoder()
            let json = JSON(jsonData)
            let dispatchGroup = DispatchGroup()
            
            var vkItemsArray: [NItem] = []
            var vkProfilesArray: [NProfile] = []
            var vkGroupsArray: [NGroup] = []
            
            let vkItemsJSONArr = json["response"]["items"].arrayValue
            let vkProfilesJSONArr = json["response"]["profiles"].arrayValue
            let vkGroupsJSONArr = json["response"]["groups"].arrayValue
            
            DispatchQueue.global().async(group: dispatchGroup) {
                
                for (index, items) in vkItemsJSONArr.enumerated() {
                    do {
                        let decodeItem = try decoder.decode(NItem.self, from: items.rawData())
                        vkItemsArray.append(decodeItem)
                    } catch(let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                print("items")
                dump(vkItemsArray)
            }
            
            // decoding frofiles
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, profiles) in vkProfilesJSONArr.enumerated() {
                    do {
                        let decodeItem = try decoder.decode(NProfile.self, from: profiles.rawData())
                        vkProfilesArray.append(decodeItem)
                    } catch(let errorDecode) {
                        print("Profile decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                print("profiles")
                dump(vkProfilesArray)
            }
            
            // decoding groups
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, groups) in vkGroupsJSONArr.enumerated() {
                    do {
                        let decodeItem = try decoder.decode(NGroup.self, from: groups.rawData())
                        vkGroupsArray.append(decodeItem)
                    } catch(let errorDecode) {
                        print("Group decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                print("groups")
                dump(vkGroupsArray)
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                
                var newsModelArray: [NewsModel] = []
                var photoArray: [NPhoto] = []
                
                for item in vkItemsArray {
                    
                    if item.sourceID < 0 {
                        
                        let group = vkGroupsArray.first{-($0.id) == item.sourceID}
                        
                        var newsModel = NewsModel(
                            sourceID: item.sourceID,
                            text: item.text,
                            photo100: group?.photo100,
                            name: group?.name ?? "no name",
                            date: item.date,
                            like: item.likes.count,
                            comments: item.comments.count,
                            reposts: item.reposts.count,
                            views: item.views?.count
                        )
                        
                        item.attachments.forEach {
                            
                            guard let post = $0.photo else { return }
                            photoArray.append(post)
                            print(post)
                            
                            newsModel.photoSizes = post.sizes
                        }
                        
                        newsModelArray.append(newsModel)
                        
                    } else {
                        let arrayProfiles = vkProfilesArray.first {
                            $0.id == item.sourceID
                        }
                        let newsModelOther = NewsModel(
                            sourceID: item.sourceID,
                            text: item.text,
                            photo100: arrayProfiles?.photo100,
                            name: arrayProfiles?.lastName ?? "no name",
                            date: item.date,
                            like: item.likes.count,
                            comments: item.comments.count,
                            reposts: item.reposts.count,
                            views: item.views?.count,
                            photoUrl: nil,
                            photoSizes: nil
                        )
                        
                        item.attachments.forEach {
                            
                            guard let post = $0.photo else { return }
                            photoArray.append(post)
                            print(post)
                            
                        }
                        
                        newsModelArray.append(newsModelOther)
                    }
                }
                completion(newsModelArray, photoArray)
            }
        }
    }
}
