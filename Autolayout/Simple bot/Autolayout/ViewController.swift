//
//  ViewController.swift
//  Autolayout
//
//  Created by Sergiu on 2/14/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var whatYouShouldWatchLabel: UILabel!
    @IBOutlet weak var addRestaurantTextFied: UITextField!
    
    @IBOutlet weak var showStackView: UIStackView!
    @IBOutlet weak var staticRestaurantShow: UILabel!
    @IBOutlet weak var restaurantSpokenStackView: UIStackView!
    
    @IBOutlet weak var addRestaurantStackView: UIStackView!
    
    var showArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [showStackView, restaurantSpokenStackView].forEach {
            $0?.isHidden = true
        }
        showStackView.isHidden = true
        restaurantSpokenStackView.isHidden = true
        
    }
    @IBAction func whatRestaurantButtonPressed(_ sender: UIButton) {
        whatYouShouldWatchLabel.text = showArray.randomElement()
        
        [whatYouShouldWatchLabel, staticRestaurantShow].forEach {
            $0?.isHidden = false
        }
    }
    
    
    
    @IBAction func addRestaurantButtonPressed(_ sender: UIButton) {
        updateShows()
    }
    
    private func updateShows() {
        guard let text = addRestaurantTextFied.text else {return}
        if !text.isEmpty {
            showArray.append(text)
            showStackView.isHidden = false
            updateShowLabel()
            
            if showArray.count > 1 {
                restaurantSpokenStackView.isHidden = false
                if !whatYouShouldWatchLabel.text!.isEmpty  {
                    staticRestaurantShow.isHidden = false
                    whatYouShouldWatchLabel.isHidden = false
                } else {
                    staticRestaurantShow.isHidden = true
                    whatYouShouldWatchLabel.isHidden = true
                }
            }
            addRestaurantTextFied.text = ""
        }
    }
    
    private func updateShowLabel(){
        showLabel.text = showArray.joined(separator: ", ")
    }
    
}

