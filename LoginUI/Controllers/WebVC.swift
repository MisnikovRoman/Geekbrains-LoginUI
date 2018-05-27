//
//  WebVC.swift
//  LoginUI
//
//  Created by Роман Мисников on 27.05.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController {

    // Outlets
    @IBOutlet weak var webView: WKWebView! {
        didSet { webView.navigationDelegate = self }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequetVkAuth()
    }

    func loadRequetVkAuth() {
        // create url with components
        guard var authUrlComponents = URLComponents(string: URL_VK_AUTH) else { print(#function); return }
            authUrlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: CLIENT_ID),
                URLQueryItem(name: "redirect_uri", value: URL_VK_REDIRECT),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "scope", value: "262150"),
                URLQueryItem(name: "v", value: "5.78"),
                URLQueryItem(name: "response_type", value: "token")]
        // get URL
        guard let authUrl = authUrlComponents.url else { print(#function); return }
        // create request
        let request = URLRequest(url: authUrl)
        // load request to webView
        webView.load(request)
    }
}

extension WebVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        // get url where we auto redirection goes
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
            else { decisionHandler(.allow); return }
        
        // take parameters from this URL
        let parameters = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        // get token from parameters dictionary
        guard let token = parameters["access_token"] else { return }
        print(token)
        
        // cancel redirection
        decisionHandler(.cancel)
    }
}












