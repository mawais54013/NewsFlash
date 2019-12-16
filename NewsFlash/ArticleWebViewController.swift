//
//  ArticleWebViewController.swift
//  NewsFlash
//
//  Created by muhammad Awais on 12/7/19.
//  Copyright © 2019 muhammad Awais. All rights reserved.
//

import UIKit
import WebKit

class ArticleWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var article = Article()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: article.url) {
            webView.load(URLRequest(url: url))
        }
    }

}
