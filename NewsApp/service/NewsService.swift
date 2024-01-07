//
//  NewsService.swift
//  NewsApp
//
//  Created by Berk Canpolat on 7.01.2024.
//

import Foundation

enum NewsError:Error {
    case serviceError
    case parsingError
}

class NewsService {
    
    static let news = NewsService()
    
    private init() {}
    
    func getNewsData(url:URL, completion: @escaping (Result<[NewsModel],NewsError>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(NewsError.serviceError))
                return
            } else {
                let json = try? JSONDecoder().decode(ArticlesModel.self, from: data!)
                if let result = json {
                    completion(.success(result.articles!))
                } else {
                    completion(.failure(NewsError.parsingError))
                }
            }
        }.resume()
    }
    
}
