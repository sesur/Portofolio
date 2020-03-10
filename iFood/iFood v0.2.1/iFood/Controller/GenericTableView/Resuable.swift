//
//  Resuable.swift
//  iFood
//
//  Created by Sergiu on 7/16/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable {}

/// MARK: - UITableView
extension Reusable where Self: UITableViewCell  {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UITableView {
    
    func register<T: UITableViewCell>(_ :T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque cell with identifier")
        }
        return cell
    }
}
