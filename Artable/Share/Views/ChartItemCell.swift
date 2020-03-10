//
//  ChartItemCell.swift
//  Artable
//
//  Created by Sergiu on 5/27/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

protocol ChartItemDelegate: class {
    func removeItem(product: Product?)
}

class ChartItemCell: UITableViewCell {

    @IBOutlet weak var productImage: RoundedImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: ChartItemDelegate?
    
    var product: Product? {
        didSet {
            guard let safeProduct = product else {return}
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            if let price = formatter.string(from: safeProduct.price as NSNumber) {
               productTitleLabel.text = "\(safeProduct.name) \(price)"
            }
          
            if let url = URL(string: safeProduct.imageUrl){
                productImage.kf.setImage(with: url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle  = .none
    }

    @IBAction func deleteButtonPressed(_ sender: Any) {
        delegate?.removeItem(product: product)
    }
}
