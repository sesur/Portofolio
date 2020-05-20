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


class HomeController: UIViewController, PersonProtocol, Storyboarded  {
    
    weak var coordintor: MainCoordinator?
    
    var homeAction: ((Person?) -> Void)?
    var vehicleAction: ((Person?) -> Void)?
    var starshipAction: ((Person?) -> Void)?
    var filmAction: ((Person?) -> Void)?
    
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
   
    private func animate(_ button: UIButton?) {
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: {
            button?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            button?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    private func randomPerson() {
        spinner.startAnimating()
        personAPI.getRandomPerson(url: generateRandomNumber()) { (result) in
            switch result {
            case .success(let person): self.setupViews(person: person)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func generateRandomNumber() -> String {
        return String(Int.random(in: 1 ... 87))
    }
    
    private func setupViews(person: Person?) {
        self.spinner.stopAnimating()
        
        guard let person = person else {return }
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
        
        self.personProtocol = person
        
        [homeworldButtonLabel, starshipsButtonLabel, vehiclesButtonLabel, filmsButtonLabel].forEach {
            if $0?.isEnabled == true {
                self.animate($0)
            }
        }
    }
    
    @IBAction func homeworldButtonPressed(_ sender: Any) {
        homeAction?(personProtocol)
    }
    @IBAction func vehicleButtonPressed(_ sender: Any) {
        vehicleAction?(personProtocol)
    }
    @IBAction func starshipButtonPressed(_ sender: Any) {
        starshipAction?(personProtocol)
    }
    @IBAction func filmsButtonPressed(_ sender: Any) {
        filmAction?(personProtocol)
    }
    
    
}

