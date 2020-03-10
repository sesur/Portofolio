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
    
    func getStarship(url: String, completionHandler: @escaping (Starship?) -> ()) {
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
                let starship = try JSONDecoder().decode(Starship.self, from: jsonData)
                completionHandler(starship)
            } catch {
                debugPrint(error.localizedDescription)
                completionHandler(nil)
            }
            
        }
    }
    
}
