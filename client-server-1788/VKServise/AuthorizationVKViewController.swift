//
//  AuthorizationVKViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 10.12.2021.
//

import UIKit
import WebKit

class AuthorizationVKViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
//    {
//        didSet{
//            webview.navigationDelegate = self
//        }
//    }
    
    private let appId = "8023112"
        
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
                    URLQueryItem(name: "scope", value: "262150"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "state", value: "1234567"),
                    URLQueryItem(name: "v", value: "5.68")
                ]
                
                let request = URLRequest(url: urlComponents.url!)
                
                webview.load(request)
    }

}

//extension AuthorizationVKViewController: WKNavigationDelegate {
//
//
//}
