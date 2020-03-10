//
//  RegisterViewController.swift
//  Artable
//
//  Created by Sergiu on 3/25/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordCheckImage: UIImageView!
    @IBOutlet weak var passwordConfirmCheckImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTxt.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: UIControl.Event.editingChanged)
        confirmPasswordTxt.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        
        guard let passwordText = passwordTxt.text else {return}
        
        if textField == confirmPasswordTxt {
            passwordCheckImage.isHidden = false
            passwordConfirmCheckImage.isHidden  = false
        } else {
            if passwordText.isEmpty {
                passwordCheckImage.isHidden = true
                passwordConfirmCheckImage.isHidden = true
                confirmPasswordTxt.text = ""
            }
        }
        
        
        if passwordTxt.text == confirmPasswordTxt.text {
            passwordCheckImage.image = UIImage(named: AppImages.greenCheck)
            passwordConfirmCheckImage.image = UIImage(named: AppImages.greenCheck)
        } else  {
            passwordConfirmCheckImage.image = UIImage(named: AppImages.redCheck)
            passwordConfirmCheckImage.image = UIImage(named: AppImages.redCheck)
        }
    }
    
    
    
    
    @IBAction func registerClicked(_ sender: Any) {
        guard let user = usernameTxt.text, user.isNotEmpty,
            let email = emailTxt.text, email.isNotEmpty,
            let password = passwordTxt.text, password.isNotEmpty else {
                simpleAlert(title: "Error", message: "Please fill out all fields.")
                return
        }
        
        guard let confirmPassword = confirmPasswordTxt.text, confirmPassword == password  else {
         simpleAlert(title: "Error", message: "Password do not match.")
            return
        }
        
        activityIndicator.stopAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFirebaseAuthentication(error: error, viewController: self)
                return
            }
            guard let firebaseUser = result?.user  else {return}
            let artableUser = User.init(id: firebaseUser.uid, email: email, username: user, stripeId: "")
            self.createFirestoreUser(user: artableUser)
        }
        
      
        
//        guard let authUser = Auth.auth().currentUser else {return}
//        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
//        authUser.linkAndRetrieveData(with: credential) { (result, error) in
//            if let error = error {
//                debugPrint(error)
//                Auth.auth().handleFirebaseAuthentication(error: error, viewController: self)
//                return
//            }
//            print("Succesefuly registered")
//            self.activityIndicator.stopAnimating()
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    
    func createFirestoreUser(user: User) {
        //setp 1: Create doc ref
        let newUserRef = Firestore.firestore().collection("users").document(user.id)
        //setp 2: create model
        let user = User.modelToData(user: user)
        //setp 3: uploade to Firestore
        
        newUserRef.setData(user) { (error) in
            if let error = error {
                debugPrint("Unable to load new user document", error.localizedDescription)
                Auth.auth().handleFirebaseAuthentication(error: error, viewController: self)
                return
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    
}
