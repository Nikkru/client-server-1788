//
//  GroupsDB.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 27.12.2021.
//

import Foundation
import RealmSwift

// MARK: - Model for storage
class GroupsDAO: Object, Codable {
    @objc dynamic var isMember = 0
    @objc dynamic var id = 0
    @objc dynamic var isAdvertiser = 0
    @objc dynamic var isAdmin = 0
    @objc dynamic var name = ""
    @objc dynamic var screenName = ""
    @objc dynamic var photo100 = ""
    @objc dynamic var photo50 = ""
    @objc dynamic var photo200 = ""
    @objc dynamic var type = ""
    @objc dynamic var isClosed = 0
    
    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

final class GroupsDB {
    
    init() {
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 3)
    }
    
    func save(_ items: [GroupsDAO]) {
        
//        Если в каждом методе ижет свой Realm, можно создавать объект ассинхронно через try!
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
        guard  let url = realm.configuration.fileURL else { return }
        print(url)
    }
    
    func fetch() -> Results<GroupsDAO> {
        let realm = try! Realm()
        
        let groups: Results<GroupsDAO> = realm.objects(GroupsDAO.self)
        return groups
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write{
            realm.deleteAll()
        }
    }
    
    func delete(_ item: GroupsDAO) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
    }
}
