//
//  PersonAPI.swift
//  Star Trivia
//
//  Created by Sergiu on 3/13/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import Alamofire

//MARK:- Request with Alamofire & Codable
class PersonAPI {
    func parseRandom(url: String, completion: @escaping (MyResult<Person?>) -> Void ) {
        guard let id = URL(string: "\(PERSON_URL)\(url)") else {return}
        getGenericData(url: id, completion: completion)
    } 
}
