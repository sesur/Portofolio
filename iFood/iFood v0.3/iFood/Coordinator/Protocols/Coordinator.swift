//
//  Coordinator.swift
//  iFood
//
//  Created by Sergiu on 7/27/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
