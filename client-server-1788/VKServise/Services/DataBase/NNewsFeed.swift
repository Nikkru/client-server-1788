//
//  NNewsFeed.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 03.02.2022.
//

import Foundation

// MARK: - NNewsFeed
struct NNewsFeed: Codable {
    let response: NResponse
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
    let id, date, ownerID, fromID: Int
    let postType, text: String
    let markedAsAds: Int?
    let attachments: [NAttachment]
    let postSource: NPostSource
    let comments: NComments
    let likes: NLikes
    let reposts: NReposts
    let isFavorite: Bool
    let donut: Donut
    let shortTextRate: Double
    let carouselOffset: Int
    let views: Views?

    enum CodingKeys: String, CodingKey {
        case id, date
        case ownerID = "owner_id"
        case fromID = "from_id"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts
        case isFavorite = "is_favorite"
        case donut
        case shortTextRate = "short_text_rate"
        case carouselOffset = "carousel_offset"
        case views
    }
}

// MARK: - Attachment
struct NAttachment: Codable {
    let type: NAttachmentType
    let photo: NPhoto?
    let link: NLink?
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
    let height: Int
    let url: String
    let type: NSizeType
    let width: Int
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
    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
        case groupsCanPost = "groups_can_post"
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
