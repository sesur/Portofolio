//
//  Storyboarded.swift
//  iFood
//
//  Created by Sergiu on 6/14/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
//        let className = String(describing: self)
        let name = NSStringFromClass(self)
        let className = name.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
