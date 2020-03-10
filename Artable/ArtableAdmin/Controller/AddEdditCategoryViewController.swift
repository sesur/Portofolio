//
//  AddEdditViewController.swift
//  ArtableAdmin
//
//  Created by Sergiu on 4/14/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class AddEdditCategoryViewController: UIViewController {
    @IBOutlet weak var categoryNameText: UITextField!
    @IBOutlet weak var categoryImage: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var edditLabel: RoundedButton!
    
    
    var categoryToEdit: Category? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        
        if let category = categoryToEdit {
            categoryNameText.text = category.name
            edditLabel.setTitle("Eddit Changes", for: .normal)
            
            guard let imageUrl = URL(string: category.imageUrl) else {return}
            categoryImage.contentMode = .scaleAspectFill
            categoryImage.kf.setImage(with: imageUrl)
        }
        
    }
    
    @objc func addTap() {
        launchPicker()
    }
    
    fileprivate func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addTap))
        tap.numberOfTapsRequired = 1
        categoryImage.isUserInteractionEnabled = true
        categoryImage.addGestureRecognizer(tap)
    }
    
    @IBAction func addCategoryButtonPressed(_ sender: Any) {
        uploadImageThenDocument()
    }
    
    func uploadImageThenDocument() {
        guard let image = categoryImage.image,
            let categoryName = categoryNameText.text, categoryName.isNotEmpty  else {
                simpleAlert(titl: "Error", message: "Must enter category name and image")
                return
        }
        
        activityIndicator.startAnimating()
        
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {return}
        let storageRef = Storage.storage().reference().child("/categoryImages/\(categoryName).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                self.handleError(error: error, message: "Unable to upload image")
                return
            }
            
            storageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    self.handleError(error: error, message: "Unable to retrive image url")
                    return
                }
                guard let imageUrl = url else {return}
                self.uploadDocument(url: imageUrl.absoluteString)
            })
            
        }
    }
    func uploadDocument(url: String) {
        var documentRef: DocumentReference!
        var category = Category(id: "", name: categoryNameText.text!, imageUrl: url, timeStamp: Timestamp())
        
        if let categoryToEdit = categoryToEdit {
            documentRef = Firestore.firestore().collection("categories").document(categoryToEdit.id)
            category.id = categoryToEdit.id
        } else {
            documentRef = Firestore.firestore().collection("categories").document()
            category.id = documentRef.documentID
        }
        
        let data = Category.dataToDictionary(category: category)
        
        documentRef.setData(data, merge: true) { (error) in
            if let error = error {
                self.handleError(error: error, message: "Unable to upload new category to Firestore")
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func handleError(error: Error, message: String) {
        debugPrint(error.localizedDescription)
        simpleAlert(titl: "Error", message: message)
        activityIndicator.stopAnimating()
    }
}

extension AddEdditCategoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        categoryImage.contentMode = .scaleAspectFill
        categoryImage.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

