//
//  NNewsFeed.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 03.02.2022.
//

import Foundation

// MARK: - NNewsFeed
struct NNewsFeed: Codable {
    let response: NNewsResponse
}

struct NNewsResponse: Codable {
    let items: [NItem]
    let profiles: [NProfile]
    let groups: [NGroup]
}

// Общая модель
struct NewsModel: Codable {
    
        let sourceID: Int?
        let text: String?
        let photo100: String?
        let name: String
        let date: Int?
        let like: Int?
        let comments: Int?
        let reposts: Int?
        let views: Int?
        
        var photoUrl: String?
        var photoSizes: [NSize]? //photoSize.last, photoSize.first
        var photoPost: [NPhoto]?
    
    enum CodingKeys: String, CodingKey {
        
        case sourceID = "source_ID"
        case text, name, photoUrl
        case photo100 = "photo_100"
        case date, like, comments, reposts, views
        case photoSizes
        case photoPost
    }
}

// MARK: - Response
struct NResponse: Codable {
    let items: [NItem]
    let nextFrom: String
    let count, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case items
        case nextFrom = "next_from"
        case count
        case totalCount = "total_count"
    }
}

// MARK: - Item
struct NItem: Codable {
//    let id: Int
    let date: Int
    let sourceID: Int
    let text: String
    let attachments: [NAttachment]
    let comments: NComments
    let likes: NLikes
    let reposts: NReposts
    let views: Views?
    //        let ownerID: Int
//    let fromID: Int
//    let postType: String
//    let markedAsAds: Int?
//    let postSource: NPostSource
//    let isFavorite: Bool
//    let donut: Donut
//    let shortTextRate: Double
//    let carouselOffset: Int
    

    enum CodingKeys: String, CodingKey {
//        case id
        case date
        case sourceID = "source_id"
        case text
        case attachments
        case comments, likes, reposts
        case views
//        case ownerID = "owner_id"
//        case fromID = "from_id"
//        case postType = "post_type"
//        case markedAsAds = "marked_as_ads"
//        case postSource = "post_source"
//        case isFavorite = "is_favorite"
//        case donut
//        case shortTextRate = "short_text_rate"
//        case carouselOffset = "carousel_offset"
    }
}

struct NProfile: Codable {
    let id: Int
//    let isClosed: Bool
//    let online: Int
//    let onlineMobile, sex: Int
//    let canAccessClosed: Bool
//    let onlineApp: Int
    let firstName: String
    let photo50: String
    let lastName: String
    let photo100: String?
//    let screenName: String
//    let onlineInfo: OnlineInfo

    enum CodingKeys: String, CodingKey {
        case id
//        case isClosed = "is_closed"
//        case online
//        case onlineMobile = "online_mobile"
//        case sex
//        case canAccessClosed = "can_access_closed"
//        case onlineApp = "online_app"
        case firstName = "first_name"
        case photo50 = "photo_50"
        case lastName = "last_name"
        case photo100 = "photo_100"
//        case screenName = "screen_name"
//        case onlineInfo = "online_info"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let appID: Int
    let isMobile: Bool
    let lastSeen: Int
    let isOnline, visible: Bool

    enum CodingKeys: String, CodingKey {
        case appID = "app_id"
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case visible
    }
}

struct NGroup: Codable {
//    let photo50: String
    let id: Int
    let name: String
    let photo100: String?
    
    enum CodingKeys: String, CodingKey {
//        case photo50 = "photo_50"
        case id, name
        case photo100 = "photo_100"
  
    }
}

// MARK: - Attachment
struct NAttachment: Codable {
//    let type: NAttachmentType
    let photo: NPhoto?
//    let link: NLink?
}

// MARK: - Link
struct NLink: Codable {
    let url: String
    let title, linkDescription, target: String
    let isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case url, title
        case linkDescription = "description"
        case target
        case isFavorite = "is_favorite"
    }
}

// MARK: - Photo
struct NPhoto: Codable {
    let albumID, date, id, ownerID: Int
    let accessKey: String
    let sizes: [NSize]
    let text: String
    let userID: Int?
    let hasTags: Bool

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
    }
}

// MARK: - Size
struct NSize: Codable {
    let height: Int?
    let url: String?
    let type: NSizeType?
    let width: Int?
}

enum NSizeType: String, Codable {
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

enum NAttachmentType: String, Codable {
    case link = "link"
    case photo = "photo"
}

// MARK: - Comments
struct NComments: Codable {
    let canPost, count: Int
//    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
//        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Donut
struct NDonut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct NLikes: Codable {
    let canLike, count, userLikes, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

// MARK: - PostSource
struct NPostSource: Codable {
    let platform: String?
    let type: String
}

// MARK: - Reposts
struct NReposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct NViews: Codable {
    let count: Int
}
