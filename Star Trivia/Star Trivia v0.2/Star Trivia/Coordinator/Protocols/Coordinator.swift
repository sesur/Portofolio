//
//  Coordinator.swift
//  Star Trivia
//
//  Created by Sergiu on 6/17/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject{
    var coordinatorChild: [Coordinator] {get set}
    var navigatioController: UINavigationController {get set}
    
    func start()
}
