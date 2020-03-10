//
//  MainCoordinator.swift
//  iFood
//
//  Created by Sergiu on 6/14/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, MainMenuProtocol, UINavigationControllerDelegate {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let menuViewController = MenuViewController.instantiate()
        menuViewController.cellAction = { [weak self] title in
            self?.showSubmenu(title: title)
        }
        navigationController.pushViewController(menuViewController, animated: true)
    }
    
    
    func showSubmenu(title: String) {
        let child = SubmenuCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.selectedTitle = title
        child.start()
    }

    
    //MARK:- UInavigationControllerDelegate
    func removeDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
        if navigationController.viewControllers.contains(fromViewController) {return}
        
        if let menuViewController = fromViewController as? SubmenuViewController {
            removeDidFinish(menuViewController.coordinator)
        }
    }
}
