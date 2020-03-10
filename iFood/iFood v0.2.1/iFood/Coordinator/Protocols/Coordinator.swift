//
//  Coordinator.swift
//  iFood
//
//  Created by Sergiu on 6/14/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}



