//
//  PersonAPI.swift
//  Star Trivia
//
//  Created by Sergiu on 3/13/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import Alamofire
//import SwiftyJSON

class PersonAPI {
    
    //MARK:- Request with Alamofire & Codable
    func getRandomPersonWithAlamofireAndCodable(id: Int, completionHandler: @escaping (Person?) -> () ) {
        guard let url = URL(string: "\(PERSON_URL)\(id)") else {return}
        
        AF.request(url).responseJSON { (response) in
            if let error = response.error {
                debugPrint(error.localizedDescription)
                completionHandler(nil)
                return
            }
        
        
//        AF.request(url).responseJSON { (response) in
//            if let error = response.result.error {
//                debugPrint(error.localizedDescription)
//                completionHandler(nil)
//                return
//            }
            
            guard let data = response.data else {return completionHandler(nil)}
            let json = JSONDecoder()
            do {
                let person = try json.decode(Person.self, from: data)
                completionHandler(person)
            } catch {
                debugPrint(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
    
    
    
    //MARK:- Request with Alamofire & SwiftyJSON
//    func getRandomPersonWithAlamofireAndSiftyJSON(id: Int, completionHandler: @escaping (Person?) -> () ) {
//        guard let url = URL(string: "\(PERSON_URL)\(id)") else {return}
//        
//        AF.request(url).responseJSON { (response) in
//            if let error = response.result.error {
//                debugPrint(error.localizedDescription)
//                completionHandler(nil)
//                return
//            }
//            
//            guard let data = response.data else { return completionHandler(nil)}
//            do {
//                let json = try JSON(data: data)
//                let person = self.parsePersonWithSwiftyJSON(json: json)
//                completionHandler(person)
//                
//            } catch {
//                debugPrint(error.localizedDescription)
//                completionHandler(nil)
//            }
//            
//        }
//    }
    
    
    
    //MARK:- Request with Alamofire 
    //    func getRandomPersonWithAlamofire(id: Int, completionHandler: @escaping (Person?) -> () ) {
    //        guard let url = URL(string: "\(PERSON_URL)\(id)") else {return}
    //
    //        AF.request(url).responseJSON { (response) in
    //            if let error = response.result.error {
    //                debugPrint(error.localizedDescription)
    //                completionHandler(nil)
    //                return
    //            }
    //            guard let json = response.result.value as? [String: Any] else {
    //                return completionHandler(nil)
    //            }
    //            let person = self.parsePersonManual(json: json)
    //            DispatchQueue.main.async(execute: {
    //                completionHandler(person)
    //            })
    //        }
    //    }
    
    // parse with SwiftyJSON
//    private func parsePersonWithSwiftyJSON(json: JSON) -> Person {
//
//        let name = json["name"].stringValue
//        let height = json["height"].stringValue
//        let mass = json["mass"].stringValue
//        let hair = json["hair_color"].stringValue
//        let birthYear = json["birth_year"].stringValue
//        let gender = json["gender"].stringValue
//        let homeWorld = json["homeworld"].stringValue
//        let filmUrls = json["films"].arrayValue.map { $0.stringValue }
//        let vehicleUrls = json["vehicles"].arrayValue.map { $0.stringValue }
//        let starshipUrl = json["starships"].arrayValue.map { $0.stringValue }
//
//        return Person(name: name, height: height, mass: mass, hair: hair, birthYear: birthYear, gender: gender, homeWorld: homeWorld, filmUrls: filmUrls, vehicleUrls: vehicleUrls, starshipUrl: starshipUrl)
//    }
    
    //// parse manual
    //    private func parsePersonManual(json: [String: Any]) -> Person {
    //
    //        let name = json["name"] as? String ?? ""
    //        let height = json["height"] as? String ?? ""
    //        let mass = json["mass"] as? String ?? ""
    //        let hair = json["hair_color"] as? String ?? ""
    //        let birthYear = json["birth_year"] as? String ?? ""
    //        let gender = json["gender"] as? String ?? ""
    //        let homeWorld = json["homeworld"] as? String ?? ""
    //        let filmUrls = json["films"] as? [String] ?? [String]()
    //        let vehicleUrls = json["vehicles"] as? [String] ?? [String]()
    //        let starshipUrl = json["starships"] as? [String] ?? [String]()
    //
    //        return Person(name: name, height: height, mass: mass, hair: hair, birthYear: birthYear, gender: gender, films: filmUrls, vehicles: vehicleUrls, starships: starshipUrl)
    //    }
    
    
}
