//
//  Storyboarded.swift
//  iFood
//
//  Created by Sergiu on 7/27/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded: AnyObject  {
    static func instantiate() -> Self
}


extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
