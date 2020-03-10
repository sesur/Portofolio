//
//  SubmenuProtocol.swift
//  iFood
//
//  Created by Sergiu on 6/17/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation

protocol SubmenuProtocol: AnyObject  {
   func showDetail(_ recipe: Recipe?)
   func removeDidFinish(_ child: Coordinator?)
}
