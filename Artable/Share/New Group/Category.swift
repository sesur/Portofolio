//
//  Category.swift
//  Artable
//
//  Created by Sergiu on 3/30/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import FirebaseFirestore


struct Category {
    var id: String
    var name: String
    var imageUrl: String
    var isActive: Bool = true
    var timeStamp: Timestamp
    
    init(id:String, name:String, imageUrl:String, isActive:Bool = true, timeStamp:Timestamp) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.isActive = isActive
        self.timeStamp = timeStamp
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timestamp"] as? Timestamp ?? Timestamp()
    }
    
    
}

extension Category {
    static func dataToDictionary(category: Category) -> [String: Any] {
        var data = [String: Any]()
        data["id"] = category.id
        data["name"] = category.name
        data["imageUrl"] = category.imageUrl
        data["isActive"] = category.isActive
        data["timeStamp"] = category.timeStamp
        return data
    }
}
