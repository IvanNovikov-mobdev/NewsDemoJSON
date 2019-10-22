//
//  SearchResponse.swift
//  NewsDemoJSON
//
//  Created by Иван Новиков on 21.10.2019.
//  Copyright © 2019 Иван Новиков. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var totalResults: Int
    var articles: [News]
}

struct News: Decodable {
    var urlToImage: String?
    var title: String
    var description: String?
    var url: String
}
