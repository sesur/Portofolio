//
//  StarshipViewController.swift
//  Star Trivia
//
//  Created by Sergiu on 3/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class StarshipViewController: UIViewController, PersonProtocol {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var lenghtLabel: UILabel!
    @IBOutlet weak var makerLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var passangersLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var previewButtonLabel: FadeButtonAnimation!
    @IBOutlet weak var nextButtonLabel: FadeButtonAnimation!
    
    
    var personProtocol: Person?
    let api = StarshipAPI()
    var currentStarship = 0
    var starshipsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        checkFirstStarship()
    }
    
    private func checkFirstStarship() {
        starshipsArray = personProtocol?.starshipUrl ?? []
        nextButtonLabel.isEnabled = starshipsArray.count > 1
        previewButtonLabel.isEnabled = false
        
        guard let firstStarship = starshipsArray.first else {return}
        getStarship(url: firstStarship)
    }
    
    private func getStarship(url: String) {
        spinner.startAnimating()
        api.getStarship(url: url) { (starship) in
            self.spinner.stopAnimating()
            self.setupViews(starship: starship)
        }
        
    }
    
    private func setupViews(starship: Starship?) {
        guard let starship = starship else {return}
        
        name.text = starship.name
        model.text = starship.model
        lenghtLabel.text = starship.length
        makerLabel.text = starship.maker
        costLabel.text = starship.cost
        speedLabel.text = starship.speed
        crewLabel.text = starship.speed
        passangersLabel.text = starship.passengers
    }
    
    @IBAction func previewButtonPressed(_ sender: Any) {
        currentStarship -= 1
        setupButtons()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        currentStarship += 1
        setupButtons()
    }
    
    private func setupButtons() {
        previewButtonLabel.isEnabled = currentStarship == 0 ? false : true
        nextButtonLabel.isEnabled = currentStarship == starshipsArray.count - 1 ? false : true
        getStarship(url: starshipsArray[currentStarship])
        
    }
}
