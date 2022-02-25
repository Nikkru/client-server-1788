//
//  APICaller.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 19.02.2022.
//

import Foundation

class APICaller {
    
    var isPaginated = false
    
    //      симуляция запроса с задержкой в выполнении
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[String], Error>) -> Void) {
        if pagination {
            isPaginated = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 0.5 : 0.2)) {
            let originalData = [
                "Apple",
                "Google",
                "PromiseKit is a thoughtful and complete implementation of promises for any platform that has a swiftc. It has excellent Objective-C bridging and delightful specializations for iOS, macOS, tvOS and watchOS. It is a top-100 pod used in many of the most popular apps in the world.",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook"
            ]
            
            let newData = ["banana", "oranges", "grapes", "Food"]
            
            completion(.success( pagination ? newData : originalData ))
            if pagination {
                self.isPaginated = false
            }
        }
    }
}
