//
//  ViewController.swift
//  Star Trivia
//
//  Created by Sergiu on 3/11/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

protocol PersonProtocol {
    var person: Person? { get set }
}


class HomeController: UIViewController, PersonProtocol, Storyboarded {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var hair: UILabel!
    @IBOutlet weak var birthYear: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Buttons Label
    @IBOutlet weak var homeWorldLabel: UIButton!
    @IBOutlet weak var vehiclesLabel: UIButton!
    @IBOutlet weak var starshipsLabel: UIButton!
    @IBOutlet weak var filmsLabel: UIButton!
    
    var personAPI = PersonAPI()
    var person: Person?
    weak var coordinator: MainCoordinator?
    
    var navigateHome: ((Person?) -> Void)?
    var navigateToVehicle: ((Person?) -> Void)?
    var navigateToStarship: ((Person?) -> Void)?
    var navigateToFilms: ((Person?) -> Void)?
    
    //MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        generateRandomPerson()
    }
    
    //MARK: Events
    @IBAction func pressRandomButton(_ sender: Any) {
        generateRandomPerson()
    }
    
    private func startSpinning() {
        spinner.startAnimating()
    }
    
    private func stopSpinning() {
        self.spinner.stopAnimating()
    }
    
    private func generateRandomPerson() {
        startSpinning()
        personAPI.parseRandom(url: getRandomNumber()) { (result) in
            switch result {
            case .success(let person): self.update(person)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func getRandomNumber() -> String {
        return String(Int.random(in: 1 ... 87))
    }
    
    private func update(_ person: Person?) {
        stopSpinning()
        guard let person = person else { return }
        self.person = person
        updateFields(person)
        updateButtons(person)
    }
    
    private func updateFields(_ person: Person?) {
        guard let person = person else { return }
        name.text = person.name
        height.text = person.height
        mass.text  = person.mass
        hair.text = person.hair
        birthYear.text = person.birthYear
        gender.text = person.gender
    }
    
    private func updateButtons(_ person: Person) {
        homeWorldLabel.isEnabled = !person.homeWorld.isEmpty
        starshipsLabel.isEnabled = !person.starshipUrl.isEmpty
        vehiclesLabel.isEnabled = !person.vehicleUrls.isEmpty
        filmsLabel.isEnabled = !person.filmUrls.isEmpty
        
        animate([homeWorldLabel, starshipsLabel, vehiclesLabel, filmsLabel])
    }
    
    private func animate(_ button: [UIButton]) {
        button.forEach {
            if $0.isEnabled == true {
                self.transformAffine($0)
            }
        }
    }
    
    private func transformAffine(_ button: UIButton?) {
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: {
            button?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            button?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    
    
    @IBAction func pressHomeWorldButton(_ sender: Any) {
        navigateHome?(person)
    }
    @IBAction func pressVehicleButton(_ sender: Any) {
        navigateToVehicle?(person)
    }
    @IBAction func pressStarshipButton(_ sender: Any) {
        navigateToStarship?(person)
    }
    @IBAction func pressFilmsButton(_ sender: Any) {
        navigateToFilms?(person)
    }
    
    
    
}

