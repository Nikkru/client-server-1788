//
//  SessionFirebase.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 15.01.2022.
//

import Foundation
import Firebase

class SessionFirebase {
    
    let token: String
    let userId: String
    
    let ref: DatabaseReference?
    
    init(token: String, userId: String) {
        self.ref = nil
        self.token = token
        self.userId = userId
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
              let token = value["token"] as? String,
              let userId = value["userId"] as? String else { return nil }
        
        self.ref = snapshot.ref
        self.token = token
        self.userId = userId
    }
    
    // упаковка данных для хранения в словарь
    func toAnyObject() -> [String: Any] {
        // 4
        return [
            "token": token,
            "userId": userId
        ]
    }
}
