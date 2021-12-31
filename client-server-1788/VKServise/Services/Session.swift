//
//  Session.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 09.12.2021.
//

import Foundation
import SwiftKeychainWrapper

final class Session {
    
    private init() {}
    
    static let shared = Session()
    
//    var token = ""
//    var userId = ""
    var token: String {
            set {
                KeychainWrapper.standard.set(newValue, forKey: "com.gb.token")
            }
            get {
                return KeychainWrapper.standard.string(forKey: "com.gb.token") ?? ""
            }
        }

        var userId: String {
            set {
                KeychainWrapper.standard.set(newValue, forKey: "user.Id")
            }
            get {
                return KeychainWrapper.standard.string(forKey: "user.Id") ?? ""
            }
        }

        var expiresIn = ""
    
}
