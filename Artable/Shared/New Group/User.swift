//
//  User.swift
//  Artable
//
//  Created by Sergiu on 5/7/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var email: String
    var username: String
    var stripeId: String
    
    init(id: String = "", email: String = "", username: String = "", stripeId: String = "") {
        self.id = id
        self.email = email
        self.username = username
        self.stripeId = stripeId
    }
    
    init(data: [String: Any] ) {
        id = data["id"] as? String ?? ""
        email = data["email"] as? String ?? ""
        username = data["username"] as? String ?? ""
        stripeId = data["stripeId"] as? String ?? ""
    }
}


extension User {
    static func modelToData(user: User) -> [String: Any] {
        var data = [String: Any]()
        data["id"] = user.id
        data["email"] = user.email
        data["username"] = user.username
        data["stripeId"] = user.stripeId
        return data
    }
}
