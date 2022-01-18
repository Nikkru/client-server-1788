//
//  FriendFB.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 16.01.2022.
//

import Foundation
import Firebase

struct FriendFB {
    
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    let photo50: String
    
    let ref: DatabaseReference?
    
    init(id: Int,
         firstName: String,
         lastName: String,
         photo100: String,
         photo50: String) {
        
        self.ref = nil
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photo50 = photo50
        self.photo100 = photo100
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard let value = snapshot.value as? [String: Any],
              let id = value["id"] as? Int,
              let firstName = value["firstName"] as? String,
              let lastName = value["lastName"] as? String,
              let photo50 = value["photo50"] as? String,
              let photo100 = value["photo100"] as? String else { return nil}
        
        self.ref = snapshot.ref
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photo50 = photo50
        self.photo100 = photo100
    }
    
        func toAnyObject() -> [String: Any] {
        
        return [
            "id": id,
            "firstName": firstName,
            "lastName": lastName,
            "photo100": photo100,
            "photo50": photo50
        ]
    }
}
