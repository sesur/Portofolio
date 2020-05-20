//
//  Stripe.swift
//  Artable
//
//  Created by Sergiu on 5/27/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation

let StripeCart = _StripeCart()

final class _StripeCart {
    
    var cartItemsArray = [Product]()
    private let stripeCreditCardCut = 0.029
    private let flatFeeCents = 30
    var shippingFee = 0
    
    var subtotal: Int {
        var amount = 0
        for item in cartItemsArray {
            let pricePennies = Int(item.price * 100)
            amount += pricePennies
        }
        return amount
    }
    
    var processingFees: Int {
        if subtotal == 0 {
            return 0
        }
        let sub = Double(subtotal)
        let feesAndSubtotal = Int(sub * stripeCreditCardCut) + flatFeeCents
        return feesAndSubtotal
    }
    
    var total: Int {
        return subtotal + processingFees + shippingFee
    }
    
    func addItemToCart(item: Product) {
        cartItemsArray.append(item)
    }
    
    func removeItemFromCart(item: Product) {
        if let index = cartItemsArray.firstIndex(of: item) {
            cartItemsArray.remove(at: index)
        }
    }

    func clearCart() {
        cartItemsArray.removeAll()
    }
}
