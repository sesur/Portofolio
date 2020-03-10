//
//  CategoryCell.swift
//  iFood
//
//  Created by Sergiu on 3/5/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    var wrapperCell: FoodCategory? {
        didSet {
            guard let safeData = wrapperCell else { return }
            categoryImage.image = UIImage(named: safeData.imageName)
            categoryTitle.text = safeData.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImage.layer.cornerRadius = 10
    }
}

