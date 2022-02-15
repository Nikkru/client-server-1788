//
//  New.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 29.01.2022.
//

import Foundation
//import RealmSwift
//
//class New: Object, Codable {
//
//    @Persisted var date: Int
//    @Persisted var text: String
//    @Persisted var comments: Int
//    @Persisted var likes: Int?
//    @Persisted var reposts: Int?
//    @Persisted var photo: String?
//    @Persisted var author: String
//
////    override init() {}
//}
struct New {
    
    var date: Int
    var text: String?
    var comments: Int
    var likes: Int?
    var reposts: Int?
    var photo: String?
    var author: String
    var shared: Int?
    
    init(date: Int, text: String?, comments: Int, likes: Int?, reposts: Int?, photo: String?, author: String, shared: Int?) {
        
        self.date = date
        self.text = text
        self.comments = comments
        self.likes = likes
        self.reposts = reposts
        self.photo = photo
        self.author = author
        self.shared = shared
    }
    
}
