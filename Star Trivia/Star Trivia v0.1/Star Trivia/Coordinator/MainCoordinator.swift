//
//  MainCoordinator.swift
//  Star Trivia
//
//  Created by Sergiu on 6/17/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    var coordinatorChild: [Coordinator] = []
    
    var navigatioController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigatioController = navigationController
    }
    
    func start() {
        let homeController = HomeController.instantiate()
        navigatioController.pushViewController(homeController, animated: true)
    }
    
}
