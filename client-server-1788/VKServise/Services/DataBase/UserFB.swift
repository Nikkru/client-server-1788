//
//  UserFB.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 02.02.2022.
//

import Foundation
import Firebase

class UserFB {
    
    let id: Int
    let addedGroups: [GroupFB?]
    let ref: DatabaseReference?
    
    //для создания объекта
      init(id: Int, addedGroups: [GroupFB]) {

          self.id = id
          self.addedGroups = []
          self.ref = nil
      }
    
    //для получения объекта из Firebase Database
         init?(snapshot: DataSnapshot) {

             guard let value = snapshot.value as? [String: Any],
                   let id = value["id"] as? Int,
                   let addedGroups = value["addedGroups"] as? [GroupFB] else { return nil }

             self.id = id
             self.addedGroups = addedGroups
             self.ref = snapshot.ref
         }
    
    func toAnyObject() -> [String: Any] {

            return [
                "id": id,
                "addedGroups": addedGroups
            ]
        }
}
