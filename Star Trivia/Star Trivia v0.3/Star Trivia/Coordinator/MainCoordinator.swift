//
//  MainCoordinator.swift
//  Star Trivia
//
//  Created by Sergiu on 6/17/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var coordinatorChild: [Coordinator] = []
    
    var navigatioController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigatioController = navigationController
    }
    
    func start() {
        navigatioController.delegate = self
        let homeController = HomeController.instantiate()
        homeController.homeAction = { [weak self] person in
            self?.showHomeWorldController(person)
        }
        
        homeController.vehicleAction = { [weak self] vehicle in
            self?.showVehicleController(vehicle)
        }
        
        homeController.starshipAction = { [weak self] starship in
            self?.showStarshipController(starship)
        }
        homeController.filmAction = { [weak self] film in
            self?.showFilmController(film)
        }
        navigatioController.pushViewController(homeController, animated: true)
    }
    func showHomeWorldController(_ person: Person?) {
        let homewolrdController = HomewoldViewController.instantiate()
        homewolrdController.personProtocol = person
        navigatioController.pushViewController(homewolrdController, animated: true)
    }
    
    func showVehicleController(_ person: Person?) {
        let vehicleController = VehicleViewController.instantiate()
        vehicleController.personProtocol = person
        navigatioController.pushViewController(vehicleController, animated: true)
    }
    func showStarshipController(_ person: Person?) {
        let starshipController = StarshipViewController.instantiate()
        starshipController.personProtocol = person
        navigatioController.pushViewController(starshipController, animated: true)
    }
    func showFilmController(_ person: Person?) {
        let filmController = FilmViewController.instantiate()
        filmController.personProtocol = person
        navigatioController.pushViewController(filmController, animated: true)
    }
    
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in coordinatorChild.enumerated() {
            if coordinator === child {
                coordinatorChild.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
        
        if navigationController.viewControllers.contains(fromViewController) {return}
        
        if let homeViewController = fromViewController as? HomeController {
            childDidFinish(homeViewController.coordintor)
        }
    }
    
}
