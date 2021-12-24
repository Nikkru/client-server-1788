//
//  PhotosApi.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 16.12.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

final class PhotosApi {
    
    func getPhotos(completion: @escaping([PhotoDAO])->()) {
        
        let baseUrl = "https://api.vk.com/method/"
        let token = Session.shared.token
        let userId = Session.shared.userId
        let version = "5.81"
        
        let method = "photos.getAll"
        let url = baseUrl + method
        
        let parameters: Parameters = [
            "user_id": userId,
            "rev": 0,
            "fields": "photo_50, photo_100",
            "access_token": token,
            "count": 10,
            "v": version
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseJSON { response in
                    
                    print("RESPONSE.DATA: \(response.data?.prettyJSON)")
                    
                    guard let jsonData = response.data else { return }
                    
                    do {
                        
                        let itemsData = try JSON(jsonData)["response"]["items"].rawData()
                        let photos = try JSONDecoder().decode([PhotoDAO].self, from: itemsData)
                        
                        completion(photos)
                    } catch {
                        print(error)
                    }
                   }
    }
}
