//
//  Favorites.swift
//  Persistence using NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class Favorites: Codable {
    var title: String
    var tags: String
    var previewURL: String?
    var webformatURL: String?
    
    init(title: String,tags: String, previewURL: String?, webformatURL: String?) {
        self.tags = tags
        self.previewURL = previewURL
        self.webformatURL = webformatURL
        self.title = title
    }
}
