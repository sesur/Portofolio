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
    
    func getHomeworldPerson(url: String, completionHandler: @escaping (HomeworldPerson?) -> ()) {
        guard let url = URL(string: url) else {
            debugPrint("Url is not valid")
            return }
        
        AF.request(url).responseJSON { (response) in
            if let error = response.error {
                debugPrint(error.localizedDescription)
                completionHandler(nil)
                return
            }
            
            guard let jsonData  = response.data else { return completionHandler(nil) }
            do {
                let person = try JSONDecoder().decode(HomeworldPerson.self, from: jsonData)
                completionHandler(person)
            } catch {
                debugPrint(error.localizedDescription)
                completionHandler(nil)
            }
            
        }
    }
    
}
