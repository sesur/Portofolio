//
//  HomeworldAPI.swift
//  Star Trivia
//
//  Created by Sergiu on 3/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import Alamofire

class HomeworldAPI {
    func getHomeworldPerson(url: String, completion: @escaping (MyResult<HomeworldPerson?>) -> Void) {
        getGenericData(url: url, completion: completion)
    }
}
