//
//  HomeViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 13.01.2022.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let authService = Auth.auth()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signOutAction(_ sender: Any) {
        
       try? authService.signOut()
        showLoginViewController()
    }
    @IBAction func addCityAction(_ sender: Any) {
        
        
    }
 
    private func showLoginViewController() {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") else { return }
        guard let window = self.view.window else { return }
        window.rootViewController = vc
    }
}
