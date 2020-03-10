//
//  MenuDataSource.swift
//  iFood
//
//  Created by Sergiu on 8/6/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit


//class DataSource<T>: NSObject, UITableViewDataSource {
//
//    let stateController = StateController()
//
//    typealias CellConfigurator = (FoodCategory, UITableViewCell) -> Void
//
//    private let reuseIdentifier: String
//    private let cellConfigurator: CellConfigurator
//
//    init(tableView: UITableView, reuseIdentifier: String,  cellConfigurator: @escaping CellConfigurator) {
//        self.reuseIdentifier = reuseIdentifier
//        self.cellConfigurator = cellConfigurator
//        super.init()
//        tableView.dataSource = self
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return stateController.items.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let menu = self.stateController.items[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCategory", for: indexPath) as! CategoryCell
//        cellConfigurator(menu, cell)
//        return cell
//    }
//
//}
//
//extension DataSource where T == FoodCategory {
//    static func make(tableView: UITableView, reuseIdentifier: String = "cellCategory") -> DataSource {
//        return DataSource(tableView: tableView, reuseIdentifier: reuseIdentifier, cellConfigurator: { (menu, cell) in
//            let cell = cell as! CategoryCell
//            cell.wrapperCell = menu
//
//        })
//    }
//}



class GenericDataSource<T>: NSObject, UITableViewDataSource {
    
    let menu: [FoodCategory]
    typealias CellConfigurator = (FoodCategory, UITableViewCell) -> Void

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(menu: [FoodCategory], reuseIdentifier: String,  cellConfigurator: @escaping CellConfigurator) {
        self.menu = menu
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = self.menu[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(menu, cell)
        return cell
    }

}

extension GenericDataSource where T == FoodCategory {
    static func make(for menu: [FoodCategory], reuseIdentifier: String = "cellCategory") -> GenericDataSource {
        return GenericDataSource(menu: menu, reuseIdentifier: reuseIdentifier) { (menu, cell) in
            let cell = cell as! CategoryCell
            cell.wrapperCell = menu
        }
    }
}
