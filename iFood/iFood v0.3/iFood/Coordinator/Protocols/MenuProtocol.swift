//
//  MenuProtocol.swift
//  iFood
//
//  Created by Sergiu on 7/27/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation

protocol MenuProtocol {
    func showSubmenu(_ tittle: String)
    func showDetails(_ recipe: Recipe?)
    func removeDidFinish(_ child: Coordinator?)
}

extension MenuProtocol {
    func showDetails(_ recipe: Recipe?) {
        
    }
}
