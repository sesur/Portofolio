//
//  HomewoldViewController.swift
//  Star Trivia
//
//  Created by Sergiu on 3/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class HomeworldViewController: UIViewController, PersonProtocol, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var climate: UILabel!
    @IBOutlet weak var terrain: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var person: Person?
    let api = HomeworldAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        fetchHomeWorldPerson()
    }
    
    private func fetchHomeWorldPerson() {
        guard let url = person?.homeWorld else {return}
        api.getHomeworldPerson(url: url) { (result) in
            switch result {
            case .success(let person): self.updateDetailsOf(person)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func updateDetailsOf(_ person: HomeworldPerson?) {
        spinner.stopAnimating()
        guard let person = person else {return}
        name.text = person.name
        climate.text = person.climate
        terrain.text = person.terrain
        population.text = person.population
    }
}
