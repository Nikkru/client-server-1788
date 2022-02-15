//
//  GroupFB.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 17.01.2022.
//

import Foundation
import Firebase

struct GroupFB {
    
    let id: Int
    let screenName: String
    let name: String
    let photo100: String
    let photo50: String
    let type: String
    let isClosed: Int
    
    let ref: DatabaseReference?
    
    init(id: Int,
         name: String,
         screenName: String,
         photo100: String,
         photo50: String,
         type: String,
         isClosed: Int) {
        
        self.ref = nil
        self.id = id
        self.name = name
        self.screenName = screenName
        self.photo50 = photo50
        self.photo100 = photo100
        self.type = type
        self.isClosed = isClosed
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard let value = snapshot.value as? [String: Any],
              let id = value["id"] as? Int,
              let name = value["name"] as? String,
              let screenName = value["screenName"] as? String,
              let photo50 = value["photo50"] as? String,
              let photo100 = value["photo100"] as? String,
              let type = value["type"] as? String,
              let isClosed = value["isClosed"] as? Int else { return nil}
        
        self.ref = snapshot.ref
        self.id = id
        self.name = name
        self.screenName = screenName
        self.photo50 = photo50
        self.photo100 = photo100
        self.type = type
        self.isClosed = isClosed
    }
    
    func toAnyObject() -> [String: Any] {
        
        return [
            "id": id,
            "name": name,
            "screenName": screenName,
            "photo100": photo100,
            "photo50": photo50,
            "type": type,
            "isClosed": isClosed
        ]
    }
}

