//
//  ProductViewController.swift
//  Artable
//
//  Created by Sergiu on 3/30/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProductViewController: UIViewController, ProductCellDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variables
    var productsArray = [Product]()
    var category: Category?
    var db: Firestore!
    var listener: ListenerRegistration!
    var showFavorites = false
    
    //MARK:- Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        setupTableView()
        navigationItem.title = category?.name.lowercased()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setProductListener()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(true)
        if !productsArray.isEmpty {
            listener.remove()
            productsArray.removeAll()
            tableView.reloadData()
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    //MARK:- Helper methods
    func setupTableView() {
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellReuseIdentifier: Identifiers.ProductCell)
    }
    
    //MARK:- Firebase query
    func setProductListener() {
        guard let categoryId = category?.id else {return}
        
        var ref: Query!
        if showFavorites {
            ref = db.collection("users").document(UserServices.user.id).collection("favorites")
        } else {
            ref = db.products(category: categoryId)
        }
        
        listener = ref.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snapshot?.documentChanges.forEach({ (documentChange) in
                let data = documentChange.document.data()
                let product = Product(data: data)
                switch documentChange.type {
                case .added: self.onAddedDocument(change: documentChange, product: product)
                case .modified: self.onModifieDocument(change: documentChange, product: product)
                case .removed: self.onRemoveDocument(change: documentChange)
                }
            })
        })
    }
    
    func onAddedDocument(change: DocumentChange , product: Product) {
        let index = Int(change.newIndex)
        productsArray.insert(product, at: index)
        tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
    func onModifieDocument(change: DocumentChange, product: Product) {
        if change.newIndex == change.oldIndex {
            // Products changed but remained in the same position
            let index = Int(change.newIndex)
            productsArray[index] = product
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        } else {
            // Product changed position
            let newIndex = Int(change.newIndex)
            let oldIndex = Int(change.oldIndex)
            productsArray.remove(at: oldIndex)
            productsArray.insert(product, at: newIndex)
            tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
        }
    }
    func onRemoveDocument(change: DocumentChange) {
        let index = Int(change.oldIndex)
        productsArray.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
    
    //MARK:- Favorites
    fileprivate func restrictGuestFeatures() {
        if UserServices.isGuest {
            self.simpleAlert(title: "Hi friend", message: "This is a user only feature, please create a registered user to take advantage of all our features!")
            return
        }
    }
    
    func productFavorited(product: Product?) {
        if UserServices.isGuest {
            restrictGuestFeatures()
        } else {
            guard let product = product, let index = productsArray.firstIndex(of: product) else {return}
            UserServices.favoritesSelected(product: product)
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        
    }
    
    //MARK:- Add to Cart
    func addToCart(product: Product?) {
        restrictGuestFeatures()
        guard let product = product else {return}
        StripeCart.addItemToCart(item: product)
    }
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ProductCell, for: indexPath) as! ProductCell
        cell.product = productsArray[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.product = productsArray[indexPath.row]
        productDetailViewController.modalTransitionStyle = .crossDissolve
        productDetailViewController.modalPresentationStyle = .overCurrentContext
        present(productDetailViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}




//Fake Products

//let product = Product(id: "id", name: "ProductTest Name", category: "id", productDescription: "tra ta ta", imageUrl: "https://images.unsplash.com/photo-1552057588-22dab98fee07?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80", isActive: true, stock: 1, price: 99.9, timeStamp: Timestamp(), favorite: true)
//let product1 = Product(id: "id", name: "ProductTest Name1", category: "id", productDescription: "tra ta ta", imageUrl: "https://images.unsplash.com/photo-1552057588-22dab98fee07?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80", isActive: true, stock: 1, price: 99.9, timeStamp: Timestamp(), favorite: true)
//
//productsArray.append(product)
//productsArray.append(product1)
