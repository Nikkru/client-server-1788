//
//  Photo.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 16.12.2021.
//

import Foundation

//   let photosContainer = try? newJSONDecoder().decode(PhotosContainer.self, from: jsonData)

// MARK: - PhotosContainer
struct PhotosContainer: Codable {
    let response: PhotosResponse
}

// MARK: - Response
struct PhotosResponse: Codable {
    let count: Int
    let items: [Photo1]
}

// MARK: - Item
struct Photo1: Codable {
    let albumID, postID, id, date: Int
    let text: String
    let lat: Double
    let sizes: [Size]
    let ownerID: Int
    let long: Double

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text, lat, sizes
        case ownerID = "owner_id"
        case long
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}
