//
//  TableViewHelpes.swift
//  QuizTests
//
//  Created by Sergiu on 11/1/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func cell(atRow row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    func title(atRow row: Int) -> String? {
        return cell(atRow: row)?.textLabel?.text
    }
    
    func select(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexPath)
    }
    
    func deselect(row: Int) {
        let indexPath = IndexPath(row: 0, section: 0)
        deselectRow(at: indexPath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
    
}

