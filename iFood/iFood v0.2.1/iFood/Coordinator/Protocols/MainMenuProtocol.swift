//
//  MainMenuProtocol.swift
//  iFood
//
//  Created by Sergiu on 6/14/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

protocol MainMenuProtocol: AnyObject {
    func showSubmenu(title: String)
    func removeDidFinish(_ child: Coordinator?)
}
