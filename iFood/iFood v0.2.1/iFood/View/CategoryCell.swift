//
//  CategoryCell.swift
//  iFood
//
//  Created by Sergiu on 3/5/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
class CategoryCell: GenericCell<FoodCategory> {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override var item: FoodCategory? {
        didSet {
            
            DispatchQueue.main.async {
                guard let safeData = self.item else {
                    print("No data")
                    return }
             
//                self.categoryImage.image = UIImage(named: safeData.imageName)
                print(safeData.title.rawValue)
//                self.categoryTitle.text = safeData.title.rawValue
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImage.layer.cornerRadius = 10
    }
}

