//
//  Question.swift
//  Quiz
//
//  Created by Sergiu on 4/9/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation

enum Question<T: Hashable>: Hashable {
    case singleSelection(T)
    case multipleSelection(T)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .singleSelection(let value):
            hasher.combine(value)
        case .multipleSelection(let value):
            hasher.combine(value)
        }
    }
    
    static func ==(lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs, rhs) {
        case (.singleSelection(let a), .singleSelection(let b)):
            return a == b
        case (.multipleSelection(let a), .multipleSelection(let b)):
            return a == b
        default:
            return false
        }
    }
    
}
