//
//  DetailsViewController.swift
//  iFood
//
//  Created by Sergiu on 3/11/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    
    var recipe: Recipe?

    override func viewDidLoad() {
        super .viewDidLoad()
        
        guard let safe = recipe else { return}
        recipeImage.image = UIImage(named: safe.imageName)
        recipeTitle.text = safe.title
        recipeDescription.text = safe.instructions
    }
}

