//
//  StateController.swift
//  iFood
//
//  Created by Sergiu on 8/7/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation


class StateController {
    
    static let data = DataSet()
    private (set) var items: [FoodCategory] = data.categories
    
    func addItem(item: FoodCategory) {
        items.append(item)
    }
}
