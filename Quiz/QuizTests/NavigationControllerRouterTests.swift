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
    
    //    func test_routeToQuestion_presentQuestionController() {
    //        let navigationController = UINavigationController()
    //        let sut = NavigationControllerRouter(navigationController)
    //
    //        sut.routeTo(question: "Q1", answerCallback: { _ in })
    //        XCTAssertEqual(navigationController.viewControllers.count, 1)
    //    }
    //
    //    func test_routeToQuestionTwice_presentQuestionController() {
    //        let navigationController = UINavigationController()
    //        let sut = NavigationControllerRouter(navigationController)
    //
    //        sut.routeTo(question: "Q1", answerCallback: { _ in })
    //        sut.routeTo(question: "Q2", answerCallback: { _ in })
    //
    //        XCTAssertEqual(navigationController.viewControllers.count, 2)
    //    }
    
    func test_routeToQuestion_showsViewController() {
        let navigationController = UINavigationController()
        let factory = ViewControllerFacoryStub()
        let viewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }
    
    
    func test_routeToSecondQuestion_showsViewController() {
        let navigationController = UINavigationController()
        let factory = ViewControllerFacoryStub()
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)
        
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToSecondQuestion_showsViewController_withRightCallback() {
        let navigationController = UINavigationController()
        let factory = ViewControllerFacoryStub()
        let viewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        var answerCallBackFired = false
        sut.routeTo(question: "Q1", answerCallback: { _ in answerCallBackFired = true })
        factory.answerCallback["Q1"]!("anything")
        
        XCTAssertTrue(answerCallBackFired)
    }
    
    
    
    class ViewControllerFacoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [String: UIViewController]()
        var answerCallback = [String: (String) -> Void]()
        
        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question]!
        }
    }
}
