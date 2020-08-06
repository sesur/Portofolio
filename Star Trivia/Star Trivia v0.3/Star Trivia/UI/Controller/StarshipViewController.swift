//
//  StarshipViewController.swift
//  Star Trivia
//
//  Created by Sergiu on 3/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class StarshipViewController: UIViewController, PersonProtocol, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var maker: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var crew: UILabel!
    @IBOutlet weak var passengers: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var previewLabel: FadeButtonAnimation!
    @IBOutlet weak var nextButtonLabel: FadeButtonAnimation!
    
    
    var person: Person?
    let api = StarshipAPI()
    var currentStarship = 0
    var starshipsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFirstStarShip()
    }
    
    private func getFirstStarShip() {
        starshipsArray = person?.starshipUrls ?? []
        nextButtonLabel.isEnabled = starshipsArray.count > 1
        previewLabel.isEnabled = false
        
        guard let firstStarshipUrl = starshipsArray.first else {return}
        fetchStarshipFrom(firstStarshipUrl)
    }
    
    private func fetchStarshipFrom(_ url: String) {
        spinner.startAnimating()
        
        api.getStarship(url: url) { (result) in
            switch result {
            case .success(let starship): self.updateDetailsOf(starship)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func updateDetailsOf(_ starship: Starship?) {
        spinner.stopAnimating()
        
        guard let starship = starship else {return}
        name.text = starship.name
        model.text = starship.model
        length.text = starship.length
        maker.text = starship.maker
        cost.text = starship.cost
        speed.text = starship.speed
        crew.text = starship.speed
        passengers.text = starship.passengers
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
        previewLabel.isEnabled = currentStarship == 0 ? false : true
        nextButtonLabel.isEnabled = currentStarship == starshipsArray.count - 1 ? false : true
        fetchStarshipFrom(starshipsArray[currentStarship])
        
    }
}
