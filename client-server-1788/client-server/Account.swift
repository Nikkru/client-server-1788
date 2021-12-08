//
//  Account.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 08.12.2021.
//

import Foundation

final class Account {
    
    private init () {}
    
    static let shared = Account()
    
    var name = ""
    var cash = 0
}

