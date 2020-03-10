//
//  CalculatorViewController.swift
//  CalculatorTips
//
//  Created by Sergiu on 5/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {

    //Outlets
    @IBOutlet weak var tip1Label: UILabel!
    @IBOutlet weak var tip2Label: UILabel!
    @IBOutlet weak var tip3Label: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        billTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(CalculatorViewController.keyboadDidChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CalculatorViewController.keyboadDidChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CalculatorViewController.keyboadDidChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //Actions
    @IBAction func calculateButtonPressed(_ sender: Any) {
        calculateAllTips()
        hideKeyboard()
    }
    
    //Helper Methods
    func hideKeyboard(){
        billTextField.resignFirstResponder()
    }
    
    func calculateAllTips() {
        guard let inputAmount = convertCurrencyToDouble(input: billTextField.text!) else {
            print("Error: invalid numbe \(String(describing: billTextField.text))")
            return
        }
        
        // calculate tips
        let tip1 = calculateTip(subtotal: inputAmount, percentage: 10.0)
        let tip2 = calculateTip(subtotal: inputAmount, percentage: 15.5)
        let tip3 = calculateTip(subtotal: inputAmount, percentage: 20.0)
        
        print(tip1)
        print(tip2)
        print(tip3)
        
        // Udate UI
        
        tip1Label.text = convertDoubleToCurrency(amount: tip1)
        tip2Label.text = convertDoubleToCurrency(amount: tip2)
        tip3Label.text = convertDoubleToCurrency(amount: tip3)
    }
    
    func convertCurrencyToDouble(input: String) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = .current
        return numberFormatter.number(from: input)?.doubleValue
    }
    
    func convertDoubleToCurrency(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = .current
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
    
    /// - parameter percentage: a value from 0 to 100
    func calculateTip(subtotal: Double, percentage: Double) -> Double {
        return subtotal * (percentage / 100)
    }
    
    
    
    
    
    
    @objc func keyboadDidChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
                view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0

        }
    }
    
    //UItextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        calculateAllTips()
        return true
    }
    
}
