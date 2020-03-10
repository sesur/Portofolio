//
//  Person.swift
//  Star Trivia
//
//  Created by Sergiu on 3/13/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation

struct Person: Codable {
    let name: String
    let height: String
    let mass: String
    let hair: String
    let birthYear: String
    let gender: String
    let homeWorld: String
    let filmUrls: [String]
    let vehicleUrls: [String]
    let starshipUrl: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hair = "hair_color"
        case birthYear = "birth_year"
        case gender
        case homeWorld = "homeworld"
        case filmUrls = "films"
        case vehicleUrls = "vehicles"
        case starshipUrl = "starships"
    }
}


