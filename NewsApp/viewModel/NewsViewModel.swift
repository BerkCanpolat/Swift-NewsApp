//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Berk Canpolat on 7.01.2024.
//

import Foundation
import RxSwift
import RxCocoa


class NewsViewModel {
    var newsModel:PublishSubject<[NewsModel]> = PublishSubject()
    var error:PublishSubject<String> = PublishSubject()
    var loading:PublishSubject<Bool> = PublishSubject()
    
    func viewNewsData() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=31616581584b40e7a785477827989051")
        NewsService.news.getNewsData(url: url!) { result in
            switch result {
            case .success(let n):
                self.newsModel.onNext(n)
            case .failure(let error):
                switch error {
                case .serviceError:
                    self.error.onNext("Service Error")
                case .parsingError:
                    self.error.onNext("Parsing Error")
                }
            }
        }
    }
}
