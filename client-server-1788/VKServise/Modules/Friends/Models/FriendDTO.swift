//
//  FriendDTO.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 16.12.2021.
//
import Foundation
import RealmSwift

// MARK: - Item
struct FriendDTO: Codable {
    let id: Int
    let lastName: String
    let photo50: String
    let photo100: String
    let trackCode: String?
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case trackCode = "track_code"
        case firstName = "first_name"
    }
}

// MARK: - Model for storage
class FriendDAO: Object, Codable {
    @objc dynamic var lastName = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var trackCode: String?
    @objc dynamic var firstName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case trackCode = "track_code"
        case firstName = "first_name"
    }
}
