//
//  UserServices.swift
//  Artable
//
//  Created by Sergiu on 5/8/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let UserServices = _UserServices()

final class _UserServices {
    
    //Variables
    var user = User()
    var favorites = [Product]()
    var auth = Auth.auth()
    var db = Firestore.firestore()
    var userListener: ListenerRegistration? = nil
    var favoritesListener: ListenerRegistration? = nil
    
    var isGuest: Bool {
        guard let authUser = auth.currentUser else {
            return true
        }
        if authUser.isAnonymous {
            return true
        } else {
            return false
        }
    }
    
    //MARK:- Firestore Users & Favorites subcolection
    func getCurrentUser() {
        guard let authUser = auth.currentUser else {return}
        
        let userRef = db.collection("users").document(authUser.uid)
        userListener = userRef.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            guard let data = snap?.data() else {return}
            self.user = User.init(data: data)
            print(self.user)
        })
        
        getFavoritesSubcolectionOf(userRef)
    }
    
    fileprivate func getFavoritesSubcolectionOf(_ userRef: DocumentReference) {
        let favoritesRef = userRef.collection("favorites")
        favoritesListener = favoritesRef.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documents.forEach({ (document) in
                let favorite = Product.init(data: document.data())
                self.favorites.append(favorite)
            })
        })
    }
    
    //MARK:- Favorites
    func favoritesSelected(product: Product) {
        let favoritesRef = Firestore.firestore().collection("users").document(user.id).collection("favorites")
        
        if favorites.contains(product) {
            //We remove as favorites
            favorites.removeAll { $0 == product }
            favoritesRef.document(product.id).delete()
        } else {
            //We add as favorites
            favorites.append(product)
            let data = Product.modelToData(product: product)
            favoritesRef.document(product.id).setData(data)
        }
    }
    
    //MARK:- Firebase Logout
    func logoutUser() {
        userListener?.remove()
        userListener = nil
        favoritesListener?.remove()
        favoritesListener = nil
        user = User()
        favorites.removeAll()
    }
    
}
