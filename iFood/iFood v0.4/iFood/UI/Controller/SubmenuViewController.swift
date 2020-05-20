//
//  SubmenuViewController.swift
//  iFood
//
//  Created by Sergiu on 3/6/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class SubmenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    var submenuItem: String?
    var submenuArray: [Recipe]?
    
    
    var submenuAction: ((Recipe?) -> Void)?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        submenuArray = getSubmenu(submenuItem ?? "No value")
    }
    
    fileprivate func getSubmenu(_ item: String) -> [Recipe] {
        return DataSet().getRecipes(forCategoryTitle: Categories(rawValue: item)!)
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
        let recipe = submenuArray?[indexPath.item]
        submenuAction?(recipe)
    }
}
