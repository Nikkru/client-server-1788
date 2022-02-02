//
//  AuthorizationVKViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 10.12.2021.
//

import UIKit
import WebKit
import Firebase

class AuthorizationVKViewController: UIViewController {
    
    //  устанавливаем название папки для сохранения данных по Пользователю
    let ref = Database.database().reference(withPath: "LoggedUsers")
    var sessions: [SessionFirebase] = []
    
    private let appId = "8023112"
    //    private let appId = "7822904"
    
    @IBOutlet weak var webview: WKWebView!
    {
        didSet{
            webview.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configAuth()
    }
    
    private func configAuth() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: appId),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "401502"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "state", value: "1234567"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webview.load(request)
    }
}

extension AuthorizationVKViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        //  разбиваем строку ответа на массив строк
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in // собираем из массива словарь
                var dict = result // буфер
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"],
              let userId = params["user_id"] else { return }
        
        print("token = \(token)")
        print("user Id = \(userId)")
        
        Session.shared.token = token
        Session.shared.userId = userId
        
        //добавляем пользователя в Firebase
        let userFB = UserFB(id: Int(userId) ?? -1, addedGroups: [])
        let usersContainerRef = ref.child(userId)
        usersContainerRef.setValue(userFB.toAnyObject())
        
        performSegue(withIdentifier: "ShowTabBarSegue", sender: nil)
        
        decisionHandler(.cancel)
    }
}
