//
//  ViewController.swift
//  ArtableAdmin
//
//  Created by Sergiu on 3/20/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class AdminHomeViewController: UserHomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        let addCategoryButton = UIBarButtonItem(title: "Add Category", style: .plain, target: self, action: #selector(addCategory))
  
        navigationItem.rightBarButtonItem = addCategoryButton
        
    }

    @objc func addCategory() {
        performSegue(withIdentifier: Segues.toAddEditCategory, sender: self)
    }

}



