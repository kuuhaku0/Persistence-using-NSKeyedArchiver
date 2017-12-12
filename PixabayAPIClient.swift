//
//  PixabayAPIClient.swift
//  Persistence using NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
import UIKit


enum HTTPVerb: String {
    case GET
    case POST
}

struct PixabayAPIClient {
    private init() {}
    static let manager = PixabayAPIClient()
    func getPicture(from searchTerm: String,
                    completionHandler: @escaping ([Hits]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        let key = "7289995-9e56b8a2ea40563c0f18dde1f"
        let urlStr = "https://pixabay.com/api/?key=\(key)&q=\(searchTerm)&image_type=photo"
        guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL); return }
        let completion = {(data: Data) in
            do {
                let pictureInfo = try JSONDecoder().decode(Pixabay.self, from: data)
                let hitsInfo = pictureInfo.hits
                completionHandler(hitsInfo)
            }
            catch let error {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImage(from urlStr: String,
                  completionHander: @escaping (UIImage) -> Void,
                  errorHander: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHander(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {
                errorHander(.notAnImage)
                return
            }
            completionHander(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}
