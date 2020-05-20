//
//  Extensions.swift
//  Artable
//
//  Created by Sergiu on 3/25/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension UIViewController {
    func simpleAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension Int {
    func penniesToLocalCurrency() -> String {
        let dollars = Double(self) / 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let localCurrency = formatter.string(from: dollars as NSNumber) {
            return localCurrency
        }
        return "$0.00"
    }
}

