//
//  GenericAPI.swift
//  Star Trivia
//
//  Created by Sergiu on 7/10/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

enum MyResult<V> {
    case success(V)
    case failure(NewotworkingError)
}

func getGenericData<S: URLConvertible,T: Decodable>(url: S, completion: @escaping (MyResult<T>) -> Void) {
    AF.request(url).responseJSON { (response) in
        if let error = response.error {
            debugPrint(error.localizedDescription)
            completion(.failure(.invalidResponse))
            return
        }
        
        guard let data = response.data else {
            completion(.failure(.invalidData))
            return }

        do {
            let dataObject = try JSONDecoder().decode(T.self, from: data)
            completion(.success(dataObject))
        } catch {
            debugPrint(error.localizedDescription)
            completion(.failure(.invalidJSON))
        }
    }
}

enum NewotworkingError: String, Error {
    case invalidResponse = "No Internet connection, turn on your wifi or data mobile"
    case invalidData = "The server do not return any data"
    case invalidJSON = "You have decoding problem, compare your model with JSON response request"
}

extension NewotworkingError: LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "")}
}
