//
//  ProductDetailViewController.swift
//  Artable
//
//  Created by Sergiu on 4/13/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    //Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var backgroundView: UIVisualEffectView!
    
    var product: Product?
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let product = product else { return }
        productTitle.text = product.name
        productDescription.text = product.productDescription
        
        if let url = URL(string: product.imageUrl) {
            productImage.kf.setImage(with: url)
        }
       
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            productPrice.text = price
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissProduct))
        tap.numberOfTouchesRequired = 1
        backgroundView.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissProduct() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addToChartButtonPressed(_ sender: Any) {
        if UserServices.isGuest {
            self.simpleAlert(title: "Hi friend", message: "This is a user only feature, please create a registered user to take advantage of all our features!")
            return
        }
        
        if let product = product {
            StripeCart.addItemToCart(item: product)
        }
        dismissProduct()
    }
    
    @IBAction func keepShoppingButtonPressed(_ sender: Any) {
        dismissProduct()
    }
    
}
