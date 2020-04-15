//
//  iOSViewControllerFactory.swift
//  Quiz
//
//  Created by Sergiu on 4/15/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    private let options: [Question<String> : [String]]
    
    init(options: [Question<String> : [String]]) {
        self.options = options
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
        switch question {
        case .singleSelection(let value):
            return QuestionVC(question: value, options: options[question]!, selection: {_ in })
        default:
            return UIViewController()
        }
    }
    
    func resultsViewController(for results: Results<Question<String>, String>) -> UIViewController {
        return UIViewController()
    }
    
    
}
