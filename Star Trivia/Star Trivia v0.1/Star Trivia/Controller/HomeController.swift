//
//  ViewController.swift
//  Star Trivia
//
//  Created by Sergiu on 3/11/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

protocol PersonProtocol {
    var personProtocol: Person? {get set}
}


class HomeController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var hair: UILabel!
    @IBOutlet weak var birthYear: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Buttons Label
    @IBOutlet weak var homeworldButtonLabel: UIButton!
    @IBOutlet weak var vehiclesButtonLabel: UIButton!
    @IBOutlet weak var starshipsButtonLabel: UIButton!
    @IBOutlet weak var filmsButtonLabel: UIButton!
    
    
    var personAPI = PersonAPI()
    var personProtocol: Person?
    
    //MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        randomPerson()
    }
    
    //MARK: Events
    @IBAction func randomButtonPressed(_ sender: Any) {
        randomPerson()
    }
    
    private func randomPerson() {
        spinner.startAnimating()
        let randomNumber = Int.random(in: 1 ... 87)
        personAPI.getRandomPersonWithAlamofireAndCodable(id: randomNumber) { (person) in
            self.spinner.stopAnimating()
            guard let person = person else {return }
            self.setupViews(person: person)
            self.personProtocol = person
        }
    }
    
    private func setupViews(person: Person) {
        name.text = person.name
        height.text = person.height
        mass.text  = person.mass
        hair.text = person.hair
        birthYear.text = person.birthYear
        gender.text = person.gender
        
        homeworldButtonLabel.isEnabled = !person.homeWorld.isEmpty
        starshipsButtonLabel.isEnabled = !person.starshipUrl.isEmpty
        vehiclesButtonLabel.isEnabled = !person.vehicleUrls.isEmpty
        filmsButtonLabel.isEnabled = !person.filmUrls.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var destination = segue.destination as? PersonProtocol {
            destination.personProtocol = personProtocol
        }
    }

}

