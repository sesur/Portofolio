//
//  Film.swift
//  Star Trivia
//
//  Created by Sergiu on 3/19/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation

struct Film: Codable {
    let title:String
    let episode: Int
    let crawl: String
    let producer:String
    let director: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case episode = "episode_id"
        case crawl = "opening_crawl"
        case producer
        case director
        case releaseDate = "release_date"
    }
}
