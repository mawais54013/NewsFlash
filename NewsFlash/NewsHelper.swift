//
//  NewsHelper.swift
//  
//
//  Created by muhammad Awais on 12/7/19.
//

import Foundation
import Alamofire
import DocumentClassifier

class NewsHelper {
    func getArticles(returnArticles : @escaping ([Article]) -> Void) {
        
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
                            guard let classification = DocumentClassifier().classify(title + description) else { return }
                            
                            switch(classification.prediction.category) {
                            case .business:
                                article.category = .business
                                article.categoryColor = UIColor.blue
                            case .entertainment:
                                article.category = .entertainment
                                article.categoryColor = UIColor.orange
                            case .politics:
                                article.category = .politics
                                article.categoryColor = UIColor.green
                            case .sports:
                                article.category = .sports
                                article.categoryColor = UIColor.gray
                            case .technology:
                                article.category = .technology
                                article.categoryColor = UIColor.black
                            
                            }
                            
                            articles.append(article)
                        }
                        returnArticles(articles)
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
    var category : NewsCategory = .business
    var categoryColor = UIColor.red
}

enum NewsCategory : String {
    case business = "💰 Business"
    case entertainment = "🎥 Entertainment"
    case politics = "⚖️ Politics"
    case sports = "⚽️ Sports"
    case technology = "🔬 Technology"
}
