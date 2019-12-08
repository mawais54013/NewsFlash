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
