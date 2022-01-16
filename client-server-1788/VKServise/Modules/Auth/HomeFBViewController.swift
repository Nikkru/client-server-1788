//
//  HomeFBViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 16.01.2022.
//

import UIKit
import Firebase

class HomeFBViewController: UIViewController {

    let authService = Auth.auth()
    // ссылка на контейнер
//    let ref = Database.database().reference(withPath: "cities")
    
//    var cities: [FirebaseCity] = []

    override func viewDidLoad() {
        super.viewDidLoad()

//        ref.observe(.value, with: { snapshot in
//
//            print(snapshot.value as Any)
//
//            var cities: [FirebaseCity] = []
//            for child in snapshot.children {
//                if let snapshot = child as? DataSnapshot, let city = FirebaseCity(snapshot: snapshot) {
//                    cities.append(city)
//                }
//            }
////            self.cities = cities
////            let _ = self.cities.map { print($0.name, $0.zipcode)}
//        })
    }
    @IBAction func signOutAction(_ sender: Any) {
        
       try? authService.signOut()
        showLoginFBViewController()
    }
    @IBAction func goToVKAction(_ sender: Any) {
        
        VKNavigationController()
    }
 
    private func showLoginFBViewController() {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginFBViewController") else { return }
        guard let window = self.view.window else { return }
        window.rootViewController = vc
    }
    
    private func VKNavigationController() {
        guard let vc = storyboard?.instantiateViewController(identifier: "VKNavigationController") else { return }
        guard let window = self.view.window else { return }
        window.rootViewController = vc
    }
}
