//
//  ShoppingViewController.swift
//  Artable
//
//  Created by Sergiu on 5/24/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import Stripe
import FirebaseFunctions

class ShoppingViewController: UIViewController, ChartItemDelegate {
    
    // Outlets
    @IBOutlet weak var paymentMethodButton: UIButton!
    @IBOutlet weak var shippingButton: UIButton!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var shippingAndHandlingLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // Variables
    var paymentContext: STPPaymentContext!
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPaymentInfo()
        setupStripeContext()
    }
    
    fileprivate func setupPaymentInfo() {
        subtotalLabel.text = StripeCart.subtotal.penniesToLocalCurrency()
        feeLabel.text = StripeCart.processingFees.penniesToLocalCurrency()
        shippingAndHandlingLabel.text = StripeCart.shippingFee.penniesToLocalCurrency()
        totalLabel.text = StripeCart.total.penniesToLocalCurrency()
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: Identifiers.ChartItemCell, bundle: nil), forCellReuseIdentifier: Identifiers.ChartItemCell)
    }
    
    //MARK:- Stripe Context
    func setupStripeContext() {
        let config = STPPaymentConfiguration.shared()
//        config.createCardSources = true
        config.requiredShippingAddressFields = [.postalAddress]
        config.requiredBillingAddressFields = .none
        
        let customerContext = STPCustomerContext(keyProvider: StripeApi)
        paymentContext = STPPaymentContext(customerContext: customerContext, configuration: config, theme: .default())
        
        
        paymentContext.delegate = self
        paymentContext.hostViewController = self
        updateContextAmount()
    }
    
    private func updateContextAmount() {
       paymentContext.paymentAmount = StripeCart.total
    }
    
    //MARK:- CartItemDelegate method
    func removeItem(product: Product?) {
        guard let product = product else {return}
        StripeCart.removeItemFromCart(item: product)
        tableView.reloadData()
        setupPaymentInfo()
        updateContextAmount()
    }
    
    
    //MARK:- Actions
    @IBAction func placeOrderClicked(_ sender: Any) {
        paymentContext.requestPayment()
        activityIndicator.startAnimating()
    }
    
    @IBAction func paymentMethodClicked(_ sender: Any) {
        paymentContext.pushPaymentOptionsViewController()
//        paymentContext.pushPaymentMethodsViewController()
    }
    
    @IBAction func shippingMethodClicked(_ sender: Any) {
        paymentContext.pushShippingViewController()
    }
    
}




extension ShoppingViewController: STPPaymentContextDelegate {
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
        if let paymentMethod = paymentContext.selectedPaymentOption {
            paymentMethodButton.setTitle(paymentMethod.label, for: .normal)
        } else  {
            paymentMethodButton.setTitle("select method", for: .normal)
        }
        
        if let shippingMethod = paymentContext.selectedShippingMethod {
            shippingButton.setTitle(shippingMethod.label, for: .normal)
            StripeCart.shippingFee = Int(Double(truncating: shippingMethod.amount) * 100)
            setupPaymentInfo()
        } else {
            shippingButton.setTitle("select method", for: .normal)
        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        let retry = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.paymentContext.retryLoading()
        }
        alert.addAction(cancel)
        alert.addAction(retry)
        present(alert, animated: true, completion: nil)
        
    }
    
    
//    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
//          <#code#>
//      }
//
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        
        let idempontency = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        let data: [String: Any] = [
            "total" : StripeCart.total,
            "customerId" : UserServices.user.stripeId,
            "idempontency" : idempontency
        ]
        
        Functions.functions().httpsCallable("createCharge").call(data) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                self.simpleAlert(title: "Error", message: "Unable to make charge.")
                completion(.error, error)
                return
            }
            StripeCart.clearCart()
            self.tableView.reloadData()
            self.setupPaymentInfo()
            completion(.error, nil)
        }
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        let title: String
        let message:String
        
        activityIndicator.stopAnimating()
        
        switch status {
        case .error:
            title = "Error"
            message = error?.localizedDescription ?? ""
        case .success:
            title = "Success!"
            message = "Thank you for purchase"
        case .userCancellation:
            return
        @unknown default:
            fatalError()
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)

    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didUpdateShippingAddress address: STPAddress, completion: @escaping STPShippingMethodsCompletionBlock) {
        
        let ups = PKShippingMethod()
        ups.identifier = "ups_ground"
        ups.detail = "Arrives in 3-5 days"
        ups.label = "UPS"
        ups.amount = 0
        
        let fedex = PKShippingMethod()
        fedex.identifier = "fedex"
        fedex.detail = "Arrives tomorrow"
        fedex.label = "FedEx"
        ups.amount = 6.99
        
        if address.country == "US" {
            completion(.valid, nil, [ups, fedex], fedex)
        } else {
            //            completion(.invalid, nil, nil, nil)
            completion(.valid, nil, [ups, fedex], fedex)
        }
    }
    
    
}



extension ShoppingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StripeCart.cartItemsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ChartItemCell, for: indexPath) as! ChartItemCell
        cell.product = StripeCart.cartItemsArray[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
