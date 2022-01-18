//
//  FriendsDB.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 25.12.2021.
//

import Foundation
import RealmSwift

// MARK: - Item
class FriendsDAO: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var lastName = ""
    @objc dynamic var firstName = ""
    @objc dynamic var photo100 = ""
    
    let photo50: String
    let trackCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case trackCode = "track_code"
        case firstName = "first_name"
    }
}

final class FriendsDB {
    
    init() {
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 2)
    }
    
    func save(_ items: [FriendsDAO]) {
        
//        Если в каждом методе ижет свой Realm, можно создавать объект ассинхронно через try!
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
        guard  let url = realm.configuration.fileURL else { return }
        print(url)
    }
    
    func fetch() -> Results<FriendsDAO> {
        let realm = try! Realm()
        
        let friends: Results<FriendsDAO> = realm.objects(FriendsDAO.self)
        return friends
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write{
            realm.deleteAll()
        }
    }
    
    func delete(_ item: FriendsDAO) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
    }
}
