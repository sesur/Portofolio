//
//  Starship.swift
//  Star Trivia
//
//  Created by Sergiu on 3/18/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation

struct Starship: Codable {
    let name: String
    let model: String
    let maker: String
    let cost: String
    let length: String
    let speed: String
    let crew: String
    let passengers: String
    
    enum CodingKeys: String,  CodingKey {
        case name
        case model
        case maker = "manufacturer"
        case cost = "cost_in_credits"
        case length
        case speed = "max_atmosphering_speed"
        case crew
        case passengers
    }
}
