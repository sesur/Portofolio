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
    func getFilm(url: String, competion: @escaping (MyResult<Film?>) -> Void ) {
        getGenericData(url: url, completion: competion)
    }
}
