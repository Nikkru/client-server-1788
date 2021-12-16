//
//  Session.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 09.12.2021.
//

import Foundation

final class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var token = ""
    var userId = ""
    
    
}
