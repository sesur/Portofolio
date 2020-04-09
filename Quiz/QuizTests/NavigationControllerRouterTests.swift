//
//  NavigationControllerRouterTests.swift
//  QuizTests
//
//  Created by Sergiu on 4/2/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import UIKit
import XCTest
import QuizEngine
@testable import Quiz

class NavigationControllerRouterTests: XCTestCase {
    
    let navigationController = NonAnimatingNavigationController()
    let factory = ViewControllerFacoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(navigationController, factory: factory)
    }()
    
    func test_routeToSecondQuestion_showsViewController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToSecondQuestion_showsViewController_withRightCallback() {
        var answerCallBackFired = false
        sut.routeTo(question: "Q1", answerCallback: { _ in answerCallBackFired = true })
        factory.answerCallback["Q1"]!("anything")
        
        XCTAssertTrue(answerCallBackFired)
    }
    
    
    class NonAnimatingNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    
    class ViewControllerFacoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [String: UIViewController]()
        var answerCallback = [String: (String) -> Void]()
        
        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
    }
}
