//
//  UITableView+Extension.swift
//  Quiz
//
//  Created by Sergiu on 12/29/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit


extension UITableView {
    func register(for type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}
