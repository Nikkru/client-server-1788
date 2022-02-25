//
//  LoginFBViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 16.01.2022.
//

import UIKit
import Firebase

class LoginFBViewController: UIViewController {
    
    @IBOutlet weak var emailTextFIeld: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var token: AuthStateDidChangeListenerHandle!
    
    private let authServise = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        token = authServise.addStateDidChangeListener({ (auth, user) in
            
            guard user != nil else { return }
            self.showHomeFBViewController()
        })
    }
    

    @IBAction func signInAction(_ sender: Any?) {
        
        guard let email = emailTextFIeld.text,
              emailTextFIeld.hasText,
              let password = passwordTextField.text,
              passwordTextField.hasText
        else {
            showAlert(title: "Ошибка на клиенте", text: "Не ввели логин или пароль")
            return
        }
        
        authServise.signIn(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                self.showAlert(title: "Ошибка на сервере", text: error.localizedDescription)
                return
            }
            
            self.showHomeFBViewController()
        }
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        guard let email = emailTextFIeld.text,
              emailTextFIeld.hasText,
              let password = passwordTextField.text,
              passwordTextField.hasText
        else {
            showAlert(title: "Ошибка на клиенте", text: "Не ввели логин или пароль")
            return
        }
        
        authServise.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                self.showAlert(title: "Ошибка на сервере", text: error.localizedDescription)
                return
            }
            
            self.signInAction(nil)
        }
    }

    private func showHomeFBViewController() {
        guard let vc = storyboard?.instantiateViewController(identifier: "HomeFBViewController") else { return }
        guard let window = self.view.window else { return }
        window.rootViewController = vc
    }
    
    private func showAlert(title: String?, text: String?) {
        let alert = UIAlertController(title: title,
                                      message: text,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
