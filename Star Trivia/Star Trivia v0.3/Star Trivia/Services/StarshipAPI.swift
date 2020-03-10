//
//  StarshipAPI.swift
//  Star Trivia
//
//  Created by Sergiu on 3/18/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import Alamofire

class StarshipAPI {
    func getStarship(url: String, completion: @escaping (MyResult<Starship?>) -> Void) {
        getGenericData(url: url, completion: completion)
    }
}
