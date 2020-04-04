//
//  NavigationControllerRouter.swift
//  Quiz
//
//  Created by Sergiu on 4/2/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import UIKit
import QuizEngine



protocol ViewControllerFactory {
    func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController
}


class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func routeTo(result: Results<String, String>) {
        
    }
    
}
