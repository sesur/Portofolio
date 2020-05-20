//
//  ViewController.swift
//  CalculatorTips
//
//  Created by Sergiu on 5/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
 //OUtlets
    @IBOutlet weak var tip1Lable: UILabel!
    @IBOutlet weak var tip2Label: UILabel!
    @IBOutlet weak var tip3Label: UILabel!
    @IBOutlet weak var billTexField: UITextField!
    
    //Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        billTexField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyBoardDidChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyBoardDidChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyBoardDidChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //Actions
    @IBAction func calculateTipsButtonPressed(_ sender: Any) {
        print("btn pressed")
        hideKeyboard()
    }
    
    
    //UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    //Methods
    func hideKeyboard() {
        print("hide keyboard")
        billTexField.resignFirstResponder()
    }
    
    @objc func keyBoardDidChange(notification: Notification) {
        print("keyBoardDidChange: \(notification.name) ")
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        } else  {
            view.frame.origin.y = 0
        }
    }
}

