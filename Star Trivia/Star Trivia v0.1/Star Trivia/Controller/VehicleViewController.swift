//
//  VehicleViewController.swift
//  Star Trivia
//
//  Created by Sergiu on 3/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class VehicleViewController: UIViewController, PersonProtocol {
    var personProtocol: Person?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var lenghtLabel: UILabel!
    @IBOutlet weak var makerLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var passangerLabel: UILabel!
    @IBOutlet weak var previwButtonLabel: UIButton!
    @IBOutlet weak var nextButtonLabel: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let api = VehicleAPI()
    var vehiclesArray = [String]()
    var currentVehicle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.stopAnimating()
        checkvehiclesInArray()
    }
    
    private func checkvehiclesInArray() {
        vehiclesArray = personProtocol?.vehicleUrls ?? []
        nextButtonLabel.isEnabled = vehiclesArray.count > 1
        previwButtonLabel.isEnabled = false
        
        guard let firstVehicleUrl = vehiclesArray.first else {return}
        downloadVehicle(url: firstVehicleUrl)
    }
    
    private func downloadVehicle(url: String ) {
        spinner.startAnimating()
        api.getVehicle(url: url) { (vehicle) in
            self.spinner.stopAnimating()
            self.setupViews(vehicle)
        }
    }
    
    private func setupViews(_ vehicle: Vehicle?) {
        guard let vehicle = vehicle else {return}
        
        nameLabel.text = vehicle.name
        modelLabel.text = vehicle.model
        lenghtLabel.text = vehicle.length
        makerLabel.text = vehicle.manufacturer
        costLabel.text = vehicle.cost
        speedLabel.text = vehicle.speed
        crewLabel.text  = vehicle.crew
        passangerLabel.text = vehicle.passengers
    }
    
    @IBAction func previewButtonPressed(_ sender: Any) {
        currentVehicle -= 1
        setupButton()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        currentVehicle += 1
        setupButton()
    }
    
    private func setupButton() {
        nextButtonLabel.isEnabled = currentVehicle == vehiclesArray.count - 1 ? false : true
        previwButtonLabel.isEnabled = currentVehicle == 0 ? false : true
        
        downloadVehicle(url: vehiclesArray[currentVehicle])
    }
    
    
}
