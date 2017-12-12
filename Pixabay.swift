//
//  Pixabay.swift
//  Persistence using NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct Pixabay: Codable {
    let hits: [Hits]
}

struct Hits: Codable {
    let previewURL: String?
    let userImageURL: String?
    let tags: String
    let webformatURL: String?
}
