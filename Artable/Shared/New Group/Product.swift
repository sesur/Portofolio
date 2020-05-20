//
//  File.swift
//  Artable
//
//  Created by Sergiu on 3/30/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Product {
    var id: String
    var name: String
    var category: String
    var productDescription: String
    var imageUrl: String
    var isActive: Bool = true
    var stock: Int
    var price: Double
    var timeStamp: Timestamp
    var favorite: Bool
    
    init(
        id: String,
        name: String,
        category: String,
        productDescription: String,
        imageUrl: String,
        isActive: Bool = true,
        stock: Int = 0,
        price: Double,
        timeStamp: Timestamp = Timestamp(),
        favorite: Bool
        )
    {
        self.id = id
        self.name = name
        self.category = category
        self.productDescription = productDescription
        self.imageUrl = imageUrl
        self.isActive = isActive
        self.stock = stock
        self.price = price
        self.timeStamp = timeStamp
        self.favorite = favorite
    }
    
    init(data: [String: Any])
    {
        id = data["id"] as? String ?? ""
        name = data["name"] as? String ?? ""
        category = data["category"] as? String ?? ""
        productDescription = data["productDescription"] as? String ?? ""
        imageUrl = data["imageUrl"] as? String ?? ""
        isActive = data["isActive"] as? Bool ?? true
        stock = data["stock"] as? Int ?? 0
        price = data["price"] as? Double ?? 0.0
        timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        favorite = data["favorite"] as? Bool ?? true
    }
}


extension Product {
    static func modelToData(product: Product) -> [String: Any] {
        var data = [String: Any]()
        data["id"] = product.id
        data["name"] = product.name
        data["category"] = product.category
        data["productDescription"] = product.productDescription
        data["imageUrl"] = product.imageUrl
        data["isActive"] = product.isActive
        data["stock"] = product.stock
        data["price"] = product.price
        data["timeStamp"] = product.timeStamp
        data["favorite"] = product.favorite
        return data
    }
}

extension Product: Equatable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
