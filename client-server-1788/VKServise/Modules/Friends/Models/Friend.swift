//
//  Friend.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 15.12.2021.
//

import Foundation

//   let friendsContainer = try? newJSONDecoder().decode(FriendsContainer.self, from: jsonData)

import Foundation

// MARK: - FriendsContainer
struct FriendsContainer: Codable {
    let response: FriendsResponse
}

// MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {
    let id: Int
    let lastName: String
    let photo50: String
    let trackCode: String?
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case firstName = "first_name"
    }
}
