//
//  NavigationControllerRouter.swift
//  Quiz
//
//  Created by Sergiu on 4/2/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import UIKit
import QuizEngine


class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    
    func routeTo(question: Question<String>, answerCallback: @escaping ([String]) -> Void) {
        switch question {
        case .singleSelection:
             show(factory.questionViewController(for: question, answerCallback: answerCallback))
        case .multipleSelection:
            let button = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
            let viewController = factory.questionViewController(for: question, answerCallback: {_ in })
            viewController.navigationItem.rightBarButtonItem = button
             show(viewController)
        }
       
    }
    
    func routeTo(result: Results<Question<String>, [String]>) {
        show(factory.resultsViewController(for: result))
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
