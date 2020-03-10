//
//  ProductCell.swift
//  Artable
//
//  Created by Sergiu on 3/30/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import Kingfisher

protocol ProductCellDelegate: class {
    func productFavorited(product: Product?)
    func addToCart(product: Product?)
}

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLable: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: ProductCellDelegate?
    
    var product: Product? {
        didSet {
            guard let safeProduct = product else {return}
            productTitleLable.text = safeProduct.name
            
            if let url = URL(string: safeProduct.imageUrl) {
                let placeholder = UIImage(named: AppImages.placeholder)
                productImageView.kf.indicatorType = .activity
                productImageView.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.2))])
            }
            
            let formater = NumberFormatter()
            formater.numberStyle = .currency
            if let safePrice = product?.price, let price = formater.string(from: NSNumber(floatLiteral: safePrice)) {
                priceLabel.text = price
            }
            
            _ = UserServices.favorites.contains(safeProduct) ? favoriteButton.setImage(UIImage(named: AppImages.filledStar), for: .normal) : favoriteButton.setImage(UIImage(named: AppImages.emptyStar), for: .normal)
            
//            if UserServices.favorites.contains(safeProduct) {
//             favoriteButton.setImage(UIImage(named: "filled_star"), for: .normal)
//           } else {
//                favoriteButton.setImage(UIImage(named: "empty_star"), for: .normal)
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func didAddToChartPressed(_ sender: Any) {
        delegate?.addToCart(product: product)
    }
    @IBAction func didFavoriteButtonPressed(_ sender: Any) {
        delegate?.productFavorited(product: product)
    }
    
}
