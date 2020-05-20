//
//  MenuDelegate.swift
//  iFood
//
//  Created by Sergiu on 8/6/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit

class MenuDelegate: NSObject {
    
    typealias CellHandler = ((String)-> Void)?
    private let stateController: StateController
    private var cellhandler: CellHandler
    
    init(tableView: UITableView, state: StateController, completion: CellHandler) {
        self.stateController = state
        self.cellhandler = completion
        super.init()
        tableView.delegate = self
    }
}

extension MenuDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellhandler?(stateController.items[indexPath.row].title.rawValue)
    }
    
}

