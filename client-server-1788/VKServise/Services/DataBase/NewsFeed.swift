//
//  NewsFeed.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 20.01.2022.
//

import Foundation
import RealmSwift

// MARK: - Model for storage
class NewsFeed: Object, Codable {
    
    @Persisted var items: List<Item>
    @Persisted var nextFrom: String
    @Persisted var count: Int
    @Persisted var totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case items
        case nextFrom = "next_from"
        case count
        case totalCount = "total_count"
    }
}

class Item: Object, Codable {
    
    @Persisted var id: Int
    @Persisted var date: Int
    @Persisted var ownerID: Int
    @Persisted var fromID: Int
    @Persisted var postType: String
    @Persisted var text: String
    @Persisted var attachments: List<Attachment>
    let postSource: PostSource
    @Persisted var comments: Comments?
    @Persisted var likes: Likes?
    @Persisted var reposts: Reposts?
    @Persisted var isFavorite: Bool
    let donut: Donut
    @Persisted var shortTextRate: Double
    @Persisted var carouselOffset: Int
    @Persisted var views: Views?
}

class Attachment: Object, Codable {
    
    @Persisted var type: AttachmentType?
    @Persisted var photo: Photo?
    @Persisted var link: Link?
}

class AttachmentType: Object, Codable {
    
    @Persisted var link = "link"
    @Persisted var photo = "photo"
}

class Photo: Object, Codable {
    
    @Persisted var albumID: Int
    @Persisted var id: Int
    @Persisted var date: Int
    @Persisted var ownerID: Int
    @Persisted var accessKey: String
    @Persisted var sizes: List<Size>
    @Persisted var text: String
    @Persisted var userID: Int?
    @Persisted var hasTags: Bool
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id
        case date
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case sizes
        case text
        case userID = "user_id"
        case hasTags = "has_tags"
    }
}

class Size: Object, Codable {
    @Persisted var height: Int
    @Persisted var url: String
    @Persisted var type: SizeType?
    @Persisted var width: Int
}

class SizeType: Object, Codable {
    
    @Persisted var littera: String
    
    enum littera: String, Codable {
        case m = "m"
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case s = "s"
        case w = "w"
        case x = "x"
        case y = "y"
        case z = "z"
    }
}

// MARK: - Link
class Link: Object ,Codable {
    
    @Persisted var url: String
    @Persisted var title: String
    @Persisted var linkDescription: String
    @Persisted var target: String
    @Persisted var isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case url, title
        case linkDescription = "description"
        case target
        case isFavorite = "is_favorite"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let platform: String?
    let type: String
}

// MARK: - Comments
class Comments: Object, Codable {
    @Persisted var canPost: Int
    @Persisted var count: Int
    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
class Likes: Object, Codable {
    @Persisted var canLike: Int
    @Persisted var count: Int
    @Persisted var userLikes: Int
    @Persisted var canPublish: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

// MARK: - Reposts
class Reposts: Object, Codable {
    @Persisted var count: Int
    @Persisted var userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
class Views: Object, Codable {
    @Persisted var count: Int
}

final class NewsFeedDB {
    init() {
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 5)
    }
    
    func save(_ items: [NewsFeed]) {
        
   //        Если в каждом методе ижет свой Realm, можно создавать объект ассинхронно через try!
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
        guard  let url = realm.configuration.fileURL else { return }
        print(url)
    }
    
    func fetch() -> Results<NewsFeed> {
        let realm = try! Realm()
        
        let groups: Results<NewsFeed> = realm.objects(NewsFeed.self)
        return groups
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write{
            realm.deleteAll()
        }
    }
    
    func delete(_ item: NewsFeed) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
        }
    }
}

