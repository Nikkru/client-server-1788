//
//  Photo.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 16.12.2021.
//

import Foundation
import RealmSwift

// MARK: - Item
struct PhotoDTO: Codable {
    
    let albumID, id, date: Int
    let postID: Int?
    let text: String?
    let lat: Double?
    let sizes: [SizeDTO]
    let ownerID: Int
    let long: Double?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text, lat, sizes
        case ownerID = "owner_id"
        case long
    }
}

// MARK: - Size
struct SizeDTO: Codable {
    let width, height: Int
    let url: String
    let type: String
}

// MARK: - Model for storage
class PhotoDAO: Object, Codable {
    @objc dynamic var text: String?
    @objc dynamic var albumID = 0
    @objc dynamic var id = 0
    @objc dynamic var date = 0
    @objc dynamic var postID = 0
    @objc dynamic var lat: Double = 0
    var sizes: [SizeDAO]
    @objc dynamic var ownerID = 0
    @objc dynamic var long: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text, lat, sizes
        case ownerID = "owner_id"
        case long
    }
}
class SizeDAO: Object, Codable {
    @objc dynamic var width = 0
    @objc dynamic var height: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
}
