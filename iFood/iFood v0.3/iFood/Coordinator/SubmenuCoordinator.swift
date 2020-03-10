//
//  SubmenuCoordinator.swift
//  iFood
//
//  Created by Sergiu on 7/31/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class SubmenuCoordinator: NSObject, Coordinator, MenuProtocol, UINavigationControllerDelegate {

    weak var parentCoordinator: MainCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    var submenuTitle: String!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        showSubmenu(submenuTitle)
    }
    
    
    //MARK:- MenuProtocol
    func showSubmenu(_ tittle: String) {
        let submenuViewCntroller = SubmenuViewController.instantiate()
        submenuViewCntroller.submenuItem = tittle
        submenuViewCntroller.submenuAction = { [weak self] recipe in
            self?.showDetails(recipe)
        }
        
        navigationController.pushViewController(submenuViewCntroller, animated: true)
    }
    
    
    func removeDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinator.enumerated() {
            if child === coordinator {
                childCoordinator.remove(at: index)
                break
            }
        }
    }
    
    //ShowDetailsViewController
    func showDetails(_ recipe: Recipe?) {
        let detailsViewController = DetailsViewController.instantiate()
        detailsViewController.recipe = recipe
        navigationController.pushViewController(detailsViewController, animated: true)
    }

    
    //MARK:- UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
        if navigationController.viewControllers.contains(fromViewController) {return}
        
        if let detailsViewController = fromViewController as? DetailsViewController {
            removeDidFinish(detailsViewController.coordinator)
        }
    }
    
    
}
