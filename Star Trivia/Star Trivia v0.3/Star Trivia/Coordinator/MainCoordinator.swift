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
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let homeController = HomeController.instantiate()
        homeController.navigateHome = { [weak self] person in
            self?.showHomeWorldController(person)
        }
        
        homeController.navigateToVehicle = { [weak self] vehicle in
            self?.showVehicleController(vehicle)
        }
        
        homeController.navigateToStarship = { [weak self] starship in
            self?.showStarshipController(starship)
        }
        homeController.navigateToFilms = { [weak self] film in
            self?.showFilmController(film)
        }
        navigationController.pushViewController(homeController, animated: true)
    }
    func showHomeWorldController(_ person: Person?) {
        let homewolrdController = HomeworldViewController.instantiate()
        homewolrdController.person = person
        navigationController.pushViewController(homewolrdController, animated: true)
    }
    
    func showVehicleController(_ person: Person?) {
        let vehicleController = VehicleViewController.instantiate()
        vehicleController.person = person
        navigationController.pushViewController(vehicleController, animated: true)
    }
    func showStarshipController(_ person: Person?) {
        let starshipController = StarshipViewController.instantiate()
        starshipController.person = person
        navigationController.pushViewController(starshipController, animated: true)
    }
    func showFilmController(_ person: Person?) {
        let filmController = FilmViewController.instantiate()
        filmController.person = person
        navigationController.pushViewController(filmController, animated: true)
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
            childDidFinish(homeViewController.coordinator)
        }
    }
    
}
