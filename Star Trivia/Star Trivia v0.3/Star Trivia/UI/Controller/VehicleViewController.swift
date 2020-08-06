//
//  VehicleViewController.swift
//  Star Trivia
//
//  Created by Sergiu on 3/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class VehicleViewController: UIViewController, PersonProtocol, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    var person: Person?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var maker: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var crew: UILabel!
    @IBOutlet weak var passenger: UILabel!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let api = VehicleAPI()
    var vehiclesArray = [String]()
    var currentVehicle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNextAndPreviewButtons()
    }
    
    fileprivate func vehicleUrls() -> [String]  {
        return person?.vehicleUrls ?? []
    }
    
    private func setupNextAndPreviewButtons() {
        vehiclesArray = vehicleUrls()
        nextButton.isEnabled = vehiclesArray.count > 1
        previewButton.isEnabled = false
        
        guard let firstVehicleUrl = vehiclesArray.first else {return}
        fetchVehicle(from: firstVehicleUrl)
    }
    
    private func fetchVehicle(from url: String ) {
        spinner.startAnimating()
        api.getVehicle(url: url) { (result) in
            switch result {
            case .success(let vehicle): self.updateDetailsOf(vehicle)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func updateDetailsOf(_ vehicle: Vehicle?) {
        spinner.stopAnimating()
        
        guard let vehicle = vehicle else {return}
        name.text = vehicle.name
        model.text = vehicle.model
        length.text = vehicle.length
        maker.text = vehicle.manufacturer
        cost.text = vehicle.cost
        speed.text = vehicle.speed
        crew.text  = vehicle.crew
        passenger.text = vehicle.passengers
    }
    
    @IBAction func pressPreviewButton(_ sender: Any) {
        currentVehicle -= 1
        updatePreviewAndNextButton()
    }
    
    @IBAction func pressNextButton(_ sender: Any) {
        currentVehicle += 1
        updatePreviewAndNextButton()
    }
    
    private func updatePreviewAndNextButton() {
        nextButton.isEnabled = currentVehicle == vehiclesArray.count - 1 ? false : true
        previewButton.isEnabled = currentVehicle == 0 ? false : true
        fetchVehicle(from: vehiclesArray[currentVehicle])
    }
    
    
}
