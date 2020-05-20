//
//  AddEdditProductsViewController.swift
//  ArtableAdmin
//
//  Created by Sergiu on 4/17/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import  Firebase

class AddEdditProductsViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var productNametTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var productImageView: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addProductButton: RoundedButton!
    
    //MARK:- Vaiables
    var selectedCategory: Category!
    var productToEdit: Product?
    
    var name = ""
    var price = 0.0
    var productDescription = ""
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        
        if let product = productToEdit {
            productNametTextField.text = product.name
            descriptionTextField.text = product.productDescription
            priceTextField.text = String(product.price)
            addProductButton.setTitle("Save chnages", for: .normal)
            
            if let url = URL(string: product.imageUrl) {
                productImageView.contentMode = .scaleAspectFill
                productImageView.kf.setImage(with: url)
            }
        }
    }
    
    //MARK:- Actions
    fileprivate func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImagePressed))
        tap.numberOfTapsRequired = 1
        productImageView.isUserInteractionEnabled = true
        productImageView.addGestureRecognizer(tap)
    }
    
    @objc func handleImagePressed() {
        launchPicker()
    }
    
    
    @IBAction func addProductButtonPressed(_ sender: Any) {
      uploadImageThenDocument()
    }
    
    //MARK:- Helper methods
    func uploadImageThenDocument() {
        guard let image = productImageView.image,
            let name = productNametTextField.text, name.isNotEmpty,
            let description = descriptionTextField.text, description.isNotEmpty,
            let priceString = priceTextField.text,
            let price = Double(priceString) else {
                simpleAlert(titl: "Missing fields", message: "Please fill out all missing fields")
                return
        }
        
        self.name = name
        self.price = price
        self.productDescription = description
        
        activityIndicator.startAnimating()
        
        guard let imageData = image.jpegData(compressionQuality: 0.3) else {return}
        let imageRef = Storage.storage().reference().child("/productImages/\(name).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metaData) { (metadata, error) in
            if let error = error {
                self.handleError(error: error, message: "Unable to upload image")
                return
            }
            imageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    self.handleError(error: error, message: "Unable to download url ")
                    return
                }
                guard let url = url else { return }
                self.uploadDocument(url: url.absoluteString)
            })
        }
        
        
    }
    
    func uploadDocument(url: String) {
        var docRef: DocumentReference!
        var product = Product(id: "",
                              name: name,
                              category: selectedCategory.id,
                              productDescription: productDescription,
                              imageUrl: url,
                              price: price,
                              favorite: true)
        
        if let productToEdit = productToEdit {
            //update existing product
            docRef = Firestore.firestore().collection("products").document(productToEdit.id)
            product.id = productToEdit.id
        } else {
            // add new product
            docRef = Firestore.firestore().collection("products").document()
            product.id = docRef.documentID
        }
       
        let data = Product.modelToData(product: product)
        docRef.setData(data, merge: true) { (error) in
            if let error = error {
                self.handleError(error: error, message: "Unable to upload document")
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func handleError(error:Error, message: String) {
        debugPrint(error.localizedDescription)
        simpleAlert(titl: "Error", message: message)
        activityIndicator.stopAnimating()
    }
}


extension AddEdditProductsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        productImageView.contentMode = .scaleAspectFill
        productImageView.image = image
        productImageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
