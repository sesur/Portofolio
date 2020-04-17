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
        guard let options = options[question] else {
            fatalError("Couldn't load options for question: \(question)")
        }
        return questionViewController(for: question, options: options, answerCallback: answerCallback)
    }
    
    func resultsViewController(for results: Results<Question<String>, String>) -> UIViewController {
        return UIViewController()
    }
    
    
    private func questionViewController(for question: Question<String>, options: [String], answerCallback: @escaping (String) -> Void) -> UIViewController {
        switch question {
        case .singleSelection(let value):
            return QuestionVC(question: value, options: options, selection: {_ in })
        case .multipleSelection(let value):
            let controller = QuestionVC(question: value, options: options, selection: {_ in })
            _ = controller.view
            controller.tableView.allowsMultipleSelection = true
            return controller
        }
    }
}
