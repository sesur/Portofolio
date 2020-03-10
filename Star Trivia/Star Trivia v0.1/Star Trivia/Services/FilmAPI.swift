//
//  FilmAPI.swift
//  Star Trivia
//
//  Created by Sergiu on 3/19/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import Alamofire

class FilmAPI {
    
    func getFilm(url: String, competioHandler: @escaping (Film?) -> () ) {
        guard let url = URL(string: url) else {return}
        
        AF.request(url).responseJSON { (response) in
            if let error = response.error {
                debugPrint(error.localizedDescription)
                return
            }
            guard let data = response.data else {return competioHandler(nil)}
            do {
                let film = try JSONDecoder().decode(Film.self, from: data)
                competioHandler(film)
                
            } catch {
                debugPrint(error.localizedDescription)
                competioHandler(nil)
            }
        }
    }
}
