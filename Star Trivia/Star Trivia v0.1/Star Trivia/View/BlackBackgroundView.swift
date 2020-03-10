//
//  BlackBackgroundView.swift
//  Star Trivia
//
//  Created by Sergiu on 3/11/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class BlackBackgroundView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 13
        layer.backgroundColor = BLACK_BACKGROND
    }
}


class BlackBackgroundButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 13
        layer.backgroundColor = BLACK_BACKGROND
    }
}
