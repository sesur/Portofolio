//
//  VehicleAPI.swift
//  Star Trivia
//
//  Created by Sergiu on 3/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import Alamofire

class VehicleAPI {
    func getVehicle(url: String, completionHandler: @escaping (Vehicle?) -> ()) {
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
                let vehicle = try JSONDecoder().decode(Vehicle.self, from: jsonData)
                completionHandler(vehicle)
            } catch {
                debugPrint(error.localizedDescription)
                completionHandler(nil)
            }
            
        }
    }
}
