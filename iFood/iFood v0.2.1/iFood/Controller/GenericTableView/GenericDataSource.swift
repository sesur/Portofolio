//
//  GenericDataSource.swift
//  iFood
//
//  Created by Sergiu on 7/16/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource: NSObject, UITableViewDataSource {
    
    
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell =  tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
    
}
