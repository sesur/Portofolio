//
//  SubmenuCell.swift
//  iFood
//
//  Created by Sergiu on 3/6/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class SubmenuCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    var wrapperCell: Recipe? {
        didSet {
            guard let safeData = wrapperCell else {return}
            categoryImage.image = UIImage(named: safeData.imageName)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImage.layer.cornerRadius = 10
    }
}
