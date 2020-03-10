//
//  SubmenuCoordinator.swift
//  iFood
//
//  Created by Sergiu on 6/17/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class SubmenuCoordinator: NSObject,  Coordinator, SubmenuProtocol, UINavigationControllerDelegate {

    weak var parentCoordinator: MainCoordinator?
    var selectedTitle: String!
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    
    func start() {
        navigationController.delegate = self
        showSubmenu(selectedTitle)
    }
    
    fileprivate func showSubmenu(_ title: String) {
        let submenuViewController = SubmenuViewController.instantiate()
        submenuViewController.submenuItem = title
        
        submenuViewController.detailsAction = { [weak self] recipe in
            self?.showDetail(recipe)
        }
        navigationController.pushViewController(submenuViewController, animated: true)
    }
    
    
    func showDetail(_ recipe: Recipe?) {
        let detailsViewController = DetailsViewController.instantiate()
        detailsViewController.recipe = recipe
        navigationController.pushViewController(detailsViewController, animated: true)
    }
    
    
    func removeDidFinish(_ child: Coordinator?) {        
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    //MARK:- UInavigationController Delegate
  
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
        
        if navigationController.viewControllers.contains(fromViewController) {return}
        
        if let submenuViewController = fromViewController as? SubmenuViewController {
            removeDidFinish(submenuViewController.coordinator)
        }
    }
    
}
