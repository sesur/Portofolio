//
//  ViewController.swift
//  Artable
//
//  Created by Sergiu on 3/20/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import Firebase

class UserHomeViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var loginOutButtonLabel: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Variables
    var categoryArray = [Category]()
    var selectedCategory: Category?
    var db:Firestore!
    var listener: ListenerRegistration!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        setupCollectionView()
        setupInitialAnonymousUser()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setCategoriesListner()
        
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            loginOutButtonLabel.title = "Logout"
            if UserServices.userListener == nil {
                UserServices.getCurrentUser()
            }
        } else {
            loginOutButtonLabel.title = "Login"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        listener.remove()
        categoryArray.removeAll()
        collectionView.reloadData()
    }
    
    //MARK:- Setup Layouts
    func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "artable"
            guard let font = UIFont(name: "farah", size: 20) else {return}
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: font]
        } else {
            // Fallback on earlier versions
            guard let font = UIFont(name: "farah", size: 20) else {return}
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: font]
        }
        
        
        
        
        
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Identifiers.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCell)
    }
    
    
    //MARK:- Firebase Anonymous Authentication
    func setupInitialAnonymousUser() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    debugPrint(error)
                    Auth.auth().handleFirebaseAuthentication(error: error, viewController: self)
                }
            }
        }
    }
    
    
    //MARK:- Firebase Query
    func setCategoriesListner() {
        listener = db.categories.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                debugPrint(error)
                return
            }
            
            snapshot?.documentChanges.forEach({ (documentChange) in
                let data = documentChange.document.data()
                let category = Category(data: data)
                
                switch documentChange.type {
                case .added: self.onAddDocument(chanage: documentChange, category: category)
                case .modified: self.onModifiedDocument(change: documentChange, category: category)
                case .removed: self.onRemoveDocument(change: documentChange)
                }
            })
        })
    }
    
    @IBAction func didPressLoginOutButton(_ sender: Any) {
        guard let user = Auth.auth().currentUser else {return}
        
        if user.isAnonymous {
            presentLoginViewController()
        } else {
            do {
                try Auth.auth().signOut()
                UserServices.logoutUser()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        debugPrint(error)
                        Auth.auth().handleFirebaseAuthentication(error: error, viewController: self)
                    }
                    self.presentLoginViewController()
                }
                
            } catch {
                debugPrint(error)
                Auth.auth().handleFirebaseAuthentication(error: error, viewController: self)
            }
        }
        
    }
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        if UserServices.isGuest {
            self.simpleAlert(title: "Hi friend", message: "This is a user only feature, please create a registered user to take advantage of all our features!")
            return
        } else {
            performSegue(withIdentifier: Segues.toFavorites, sender: nil)
        }
        
    }
    
    //MARK:- Navigation
    fileprivate func presentLoginViewController() {
        let storyboard = UIStoryboard(name: Storyboard.loginStoryboard, bundle: nil)
        let loginViewcontroller = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.loginViewController)
        present(loginViewcontroller, animated: true, completion: nil)
    }
}



extension UserHomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categoryArray[indexPath.item]
        performSegue(withIdentifier: StoryboardIdentifier.productViewController, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardIdentifier.productViewController {
            if let destination = segue.destination as? ProductViewController {
                destination.category = selectedCategory
            }
            else {
                if let destination = segue.destination as? ProductViewController {
                    destination.category = selectedCategory
                    destination.showFavorites = true
                }
            }
        } else if  segue.identifier == "cartSegue" {
                if UserServices.isGuest {
                    self.simpleAlert(title: "Hi friend", message: "This is a user only feature, please create a registered user to take advantage of all our features!")
                    return
                }
            if let destination = segue.destination as? ProductViewController {
                destination.category = selectedCategory
                destination.showFavorites = true
            }
        }
        
        
        
    }
}

extension UserHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CategoryCell, for: indexPath) as! CategoryCell
        cell.category = categoryArray[indexPath.item]
        return cell
    }
    
    // Firestore changes
    func onAddDocument(chanage: DocumentChange, category: Category) {
        let newIndex = Int(chanage.newIndex)
        categoryArray.insert(category, at: newIndex)
        collectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
    }
    func onModifiedDocument(change:DocumentChange, category: Category) {
        if change.newIndex == change.oldIndex {
            // Item changed, but remains in the same position
            let index = Int(change.newIndex)
            categoryArray[index] = category
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        } else {
            // Item changed and changed postion
            let newIndex = Int(change.newIndex)
            let oldIndex = Int(change.oldIndex)
            categoryArray.remove(at: oldIndex)
            categoryArray.insert(category, at: newIndex)
            collectionView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
        }
        
    }
    func onRemoveDocument(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        categoryArray.remove(at: oldIndex)
        collectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
    }
}

extension UserHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 30) / 2
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
}



// The prior snap code

//    func fetchData() {
//
////        listener = db.collection("categories").document("5nFofbd3WnBu1UBvVeXj").addSnapshotListener { (snapshot, error) in
////            self.categoryArray.removeAll()
////            guard let data = snapshot?.data() else {return}
////            let category = Category(data: data)
////            self.categoryArray.append(category)
////            self.collectionView.reloadData()
////        }
//
////        db.collection("categories").document("5nFofbd3WnBu1UBvVeXj").getDocument { (snapshot, error) in
////            guard let data = snapshot?.data() else  { return }
////            let category = Category(data: data)
////            self.categoryArray.append(category)
////            self.collectionView.reloadData()
////
////        }
//    }

//    func fetchDocuments() {
//
//        listener = db.collection("categories").addSnapshotListener { (snapshot, error) in
//            self.categoryArray.removeAll()
//            guard let documents = snapshot?.documents else {return}
//            for document in documents {
//                let data = document.data()
//                let category = Category(data: data)
//                self.categoryArray.append(category)
//            }
//             self.collectionView.reloadData()
//        }
//

//        db.collection("categories").getDocuments { (snapshot, error) in
//            guard let documents = snapshot?.documents else {return}
//            for document in documents {
//                let data = document.data()
//                    let category = Category(data: data)
//                self.categoryArray.append(category)
//            }
//            self.collectionView.reloadData()
//        }
//    }
