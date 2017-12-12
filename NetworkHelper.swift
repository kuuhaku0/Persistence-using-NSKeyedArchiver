//
//  NetworkHelper.swift
//  Persistence using NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badData
    case badURL
    case codingError(rawError: Error)
    case badStatusCode(num: Int)
    case other(rawError: Error)
    case notAnImage
    case noImageAavailable
}

struct NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with url: URL,
                         completionHandler: @escaping ((Data) -> Void),
                         errorHandler: @escaping ((Error) -> Void)) {
        
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
            }
            }.resume()
    }
}


