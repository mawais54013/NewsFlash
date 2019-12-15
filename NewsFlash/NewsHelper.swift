//
//  NewsHelper.swift
//  
//
//  Created by muhammad Awais on 12/7/19.
//

import Foundation
import Alamofire

class NewsHelper {
    func getArticles() {
        
        AF.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=88a51528f6614bcd82f3d8ea3c68cce6").responseJSON { (response) in
//            print(response.result)
            
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    print(json)
                    if let jsonArticles = json["articles"] as? [[String:Any]] {
                        var articles = [Article]()
                        for jsonArticle in jsonArticles {
                            
                            guard let title = jsonArticle["title"] as? String,
                            let urlToImage = jsonArticle["urlToImage"] as? String,
                            let url = jsonArticle["url"] as? String,
                            let description = jsonArticle["description"] as? String
                                
                            else
                            {
                               continue
                            }
                            let article = Article()
                            article.title = title
                            article.urlToImage = urlToImage
                            article.url = url
                            article.description = description
                            articles.append(article)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

class Article {
    var title = ""
    var urlToImage = ""
    var url = ""
    var description = ""
    var category = ""
}
