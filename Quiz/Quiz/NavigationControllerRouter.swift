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
            let buttonViewController = SubmitButtonViewController(button, answerCallback)
            let viewController = factory.questionViewController(for: question, answerCallback: { selection in
                buttonViewController.update(selection)
            })
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


private class SubmitButtonViewController: NSObject {
    let button: UIBarButtonItem
    var callBack:([String]) -> Void
    private var model = [String]()
    
    init(_ button: UIBarButtonItem, _ callBack: @escaping ([String]) -> Void) {
        self.button = button
        self.callBack = callBack
        super.init()
        setup()
    }
    func update(_ model: [String]) {
        self.model = model
        updateButtonState()
    }

    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
        updateButtonState()
    }
    private func updateButtonState() {
        button.isEnabled = model.count > 0
    }
    
    @objc private func fireCallback() {
        callBack(model)
    }
}
