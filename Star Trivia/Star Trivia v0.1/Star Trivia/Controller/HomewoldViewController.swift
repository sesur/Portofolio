//
//  HomewoldViewController.swift
//  Star Trivia
//
//  Created by Sergiu on 3/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class HomewoldViewController: UIViewController, PersonProtocol {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var climate: UILabel!
    @IBOutlet weak var terrain: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var personProtocol: Person?
    let api = HomeworldAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        downloadHomeworldPerson()
    }
    
    private func downloadHomeworldPerson() {
        guard let url = personProtocol?.homeWorld else {return}
        api.getHomeworldPerson(url: url) { (person) in
            self.spinner.stopAnimating()
            self.setupViews(person)
        }
    }
    
    private func setupViews(_ person: HomeworldPerson?) {
        guard let person = person else {return}
        name.text = person.name
        climate.text = person.climate
        terrain.text = person.terrain
        population.text = person.population
    }
}
