//
//  SubmenuViewController.swift
//  iFood
//
//  Created by Sergiu on 3/6/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class SubmenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var submenuItem: String?
    var submenuArray: [Recipe]?
    var data = DataSet()
    var submenuDataTransfer: Recipe?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(submenuItem ?? "No Value")
        collectionView.delegate = self
        collectionView.dataSource = self
        submenuArray = data.getRecipes(forCategoryTitle: submenuItem ?? "no value")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return submenuArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "submenuCell", for: indexPath) as! SubmenuCell
        cell.wrapperCell = submenuArray?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let cellDimention = (width / 2) - 10
        return CGSize(width: cellDimention, height: cellDimention)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        submenuDataTransfer = submenuArray?[indexPath.item]
        performSegue(withIdentifier: "toDetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? DetailsViewController {
            detailsViewController.recipe = submenuDataTransfer
        }
    }
}
