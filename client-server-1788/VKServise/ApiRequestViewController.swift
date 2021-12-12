//
//  ApiRequestViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 12.12.2021.
//

import UIKit
import Alamofire

class ApiRequestViewController: UIViewController {
    
    let baseUrl = "https://api.vk.com/method/"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.81"

    override func viewDidLoad() {
        super.viewDidLoad()

        getFriendsApi()
        getPhotosApi()
    }
    private func getFriendsApi() {
        
        let method = "friends.get"
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "fields": "photo_50",
            "access_token": token,
            "count": 10,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.request ?? "fall request")
            print(response.value ?? "no value of response")
                  
              }
    }
    
    private func getPhotosApi() {
        
        let method = "photos.getAll"
        let parameters: Parameters = [
            "user_id": userId,
            "rev": 0,
            "fields": "photo_50",
            "access_token": token,
            "count": 20,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.request ?? "fall request")
            print(response.value ?? "no value of response")
                  
              }
    }

}
