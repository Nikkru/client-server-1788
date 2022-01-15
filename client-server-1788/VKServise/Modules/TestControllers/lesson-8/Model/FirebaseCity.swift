//
//  FirebaseCity.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 15.01.2022.
//

import Foundation
import Firebase

class FirebaseCity {
    // 1
    let name: String
    let zipcode: Int
    let ref: DatabaseReference?
    
    // для создания объекта
    init(name: String, zipcode: Int) {
        // 2
        self.ref = nil
        self.name = name
        self.zipcode = zipcode
    }
    
    //  для получения объекта
    init?(snapshot: DataSnapshot) {
        // 3
        guard
            let value = snapshot.value as? [String: Any],
            let zipcode = value["zipcode"] as? Int,
            let name = value["name"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.name = name
        self.zipcode = zipcode
    }
    
    // упаковка данных для хранения в словарь
    func toAnyObject() -> [String: Any] {
        // 4
        return [
            "name": name,
            "zipcode": zipcode
        ]
    }
}

