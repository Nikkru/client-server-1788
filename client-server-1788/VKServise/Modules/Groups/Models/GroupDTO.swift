//
//  GroupDTO.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 21.12.2021.
//

import Foundation
import RealmSwift

// MARK: - Item
struct GroupDTO: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

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

// MARK: - Model for storage
class GroupDAO: Object, Codable {
    
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
