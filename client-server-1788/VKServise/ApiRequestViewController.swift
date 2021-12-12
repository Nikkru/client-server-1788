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
        getGroupsApi()
        searchGroupsApi()
    }
    private func getFriendsApi() {
        
        let method = "friends.get"
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "fields": "photo_50",
            "access_token": token,
            "count": 5,
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
            "count": 5,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.request ?? "fall request")
            print(response.value ?? "no value of response")
                  
              }
    }

    private func getGroupsApi() {
        
        let method = "groups.get"
        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "access_token": token,
            "count": 5,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.request ?? "fall request")
            print(response.value ?? "no value of response")
                  
              }
    }
    
    private func searchGroupsApi() {
        
        let searchWord = "Jazz"
        
        let method = "groups.search"
        let parameters: Parameters = [
            "q": searchWord,
            "access_token": token,
            "offset": 3,
            "count": 5,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.request ?? "fall request")
            print(response.value ?? "no value of response")
                  
              }
    }
}
