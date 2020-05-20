//
//  CatagoryCell.swift
//  Artable
//
//  Created by Sergiu on 3/30/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    var category: Category? {
        didSet {
           guard let safeCategory = category else {return}
            categoryNameLabel.text = safeCategory.name
            if let url = URL(string: safeCategory.imageUrl) {
                let placeholder = UIImage(named: AppImages.placeholder)
                categoryImageView.kf.indicatorType = .activity
                categoryImageView.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.2))])
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImageView.layer.cornerRadius = 5
    }
    
}
