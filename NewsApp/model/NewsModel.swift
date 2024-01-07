//
//  NewsModel.swift
//  NewsApp
//
//  Created by Berk Canpolat on 7.01.2024.
//

import Foundation


struct NewsModel:Codable {
    var title:String?
    var description:String?
    var urlToImage:String?
    var publishedAt:String?
}

struct ArticlesModel:Codable {
    var articles:[NewsModel]?
}
