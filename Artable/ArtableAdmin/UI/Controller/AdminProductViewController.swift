//
//  AdminProductViewController.swift
//  ArtableAdmin
//
//  Created by Sergiu on 4/16/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class AdminProductViewController: ProductViewController {
    
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edditCategoryButton = UIBarButtonItem(title: "Eddit Category", style: .plain, target: self, action: #selector(onEdditCategoryButtonPressed))
        let newProductBurron = UIBarButtonItem(title: "+ Product", style: .plain, target: self, action: #selector(onNewProductButtonPressed))
        self.navigationItem.setRightBarButtonItems([edditCategoryButton, newProductBurron], animated: true)
    }
    
    @objc func onEdditCategoryButtonPressed() {
        performSegue(withIdentifier: Segues.toEditCategory, sender: self)
    }
    @objc func onNewProductButtonPressed() {
        performSegue(withIdentifier: Segues.toAddEdditProduct, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = productsArray[indexPath.row]
        performSegue(withIdentifier: Segues.toAddEdditProduct, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toAddEdditProduct {
            if let destination = segue.destination as? AddEdditProductsViewController {
                destination.selectedCategory = category
                destination.productToEdit = selectedProduct
            }
        } else if segue.identifier == Segues.toEditCategory {
            if let destination = segue.destination as? AddEdditCategoryViewController {
                destination.categoryToEdit = category
            }
        }
    }
    
    override func addToCart(product: Product?) {
        return
    }
    
    override func productFavorited(product: Product?) {
        return
    }
}
