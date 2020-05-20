//
//  StripeApi.swift
//  Artable
//
//  Created by Sergiu on 5/29/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import Stripe
import FirebaseFunctions

let StripeApi = _StripeApi()

class _StripeApi: NSObject, STPCustomerEphemeralKeyProvider {
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        
        let data = [
            "stripe_version": apiVersion,
            "customer_id": UserServices.user.stripeId
        ]
        createKey(data: data, completion: completion)
    }
    
    private func createKey(data: [String: Any], completion: @escaping STPJSONResponseCompletionBlock ) {
        Functions.functions().httpsCallable("createEphemeralKey").call(data) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(nil, error)
                return
            }
            guard let key = result?.data as? [String: Any] else {
                completion(nil, nil)
                return
            }
            completion(key, nil)
        }
    }
}

