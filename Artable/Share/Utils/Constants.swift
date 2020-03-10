//
//  Constants.swift
//  Artable
//
//  Created by Sergiu on 3/25/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit

struct Storyboard {
    static let loginStoryboard = "LoginStoryboard"
}

struct StoryboardIdentifier {
    static let loginViewController = "toLoginViewControler"
    static let productViewController = "toProductViewController"
}

struct AppImages {
    static let greenCheck = "green_check"
    static let redCheck = "red_check"
    static let filledStar = "filled_star"
    static let emptyStar = "empty_star"
    static let placeholder = "placeholder"
}

struct AppColors {
    static let pink = #colorLiteral(red: 0.88921839, green: 0.3961688387, blue: 0.4551501928, alpha: 1)
    static let blue = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    static let grey = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    
}

struct Identifiers {
    static let CategoryCell = "CategoryCell"
    static let ProductCell = "ProductCell"
    static let ChartItemCell = "ChartItemCell"
}

struct Segues {
    static let toProductViewController = "toProductViewController"
    static let toAddEditCategory = "toAddEdditCategory"
    static let toEditCategory = "toEditCategory"
    static let toAddEdditProduct = "toAddEditProduct"
    static let toFavorites = "toFavoritesViewController"
}
