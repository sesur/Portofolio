//
//  LoginViewController.swift
//  Artable
//
//  Created by Sergiu on 3/25/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var paswordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        let forgotPasswordViewController = ForgotPaswordViewController()
        forgotPasswordViewController.modalTransitionStyle = .crossDissolve
        forgotPasswordViewController.modalPresentationStyle = .overCurrentContext
        present(forgotPasswordViewController, animated: true, completion: nil)
        
        
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailTxt.text, email.isNotEmpty,
            let password = paswordTxt.text, password.isNotEmpty else {
                simpleAlert(title: "Error", message: "Please fill out all fields.")
                return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFirebaseAuthentication(error: error, viewController: self)
                self.activityIndicator.stopAnimating()
                return
            }
            
            
            self.activityIndicator.stopAnimating()
            print("Login was successful" )
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func createNewUserPressed(_ sender: Any) {
    }
    @IBAction func continueGuestButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
