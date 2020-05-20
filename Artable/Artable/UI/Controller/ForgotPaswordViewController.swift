//
//  ForgotPaswordViewController.swift
//  Artable
//
//  Created by Sergiu on 3/29/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import Firebase


class ForgotPaswordViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didCancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didResetPressed(_ sender: Any) {
        guard let email = emailTxt.text, email.isNotEmpty else {
            simpleAlert(title: "Error", message: "Please enter email.")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFirebaseAuthentication(error: error, viewController: self)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
