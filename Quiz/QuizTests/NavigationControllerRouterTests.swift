//
//  NavigationControllerRouterTests.swift
//  QuizTests
//
//  Created by Sergiu on 4/2/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import UIKit
import XCTest
@ testable import QuizEngine
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
        factory.stub(question: Question.singleSelection("Q1"), with: viewController)
        factory.stub(question: Question.singleSelection("Q2"), with: secondViewController)
        
        sut.routeTo(question: Question.singleSelection("Q1"), answerCallback: { _ in })
        sut.routeTo(question: Question.singleSelection("Q2"), answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToSecondQuestion_singleAnswer_answerCallback_progressToNextQuestion() {
        var answerCallBackFired = false
        sut.routeTo(question: Question.singleSelection("Q1"), answerCallback: { _ in answerCallBackFired = true })
        factory.answerCallback[Question.singleSelection("Q1")]!(["anything"])
        XCTAssertTrue(answerCallBackFired)
    }
    
    func test_routeToSecondQuestion_multipleAnswer_answerCallback_doeNotProgressToNextQuestion() {
        var answerCallBackFired = false
        sut.routeTo(question: Question.multipleSelection("Q1"), answerCallback: { _ in answerCallBackFired = true })
        factory.answerCallback[Question.multipleSelection("Q1")]!(["anything"])
        XCTAssertFalse(answerCallBackFired)
    }
    
    func test_routeToSecondQuestion_multipleAnswer_configuresViewControllerWithSubmittButton() {
        let viewController = UIViewController()
        factory.stub(question: Question.multipleSelection("Q1"), with: viewController)
        sut.routeTo(question: Question.multipleSelection("Q1"), answerCallback: { _ in})
        factory.answerCallback[Question.multipleSelection("Q1")]!(["anything"])
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem!)
    }
    
    
    //ResultViewController
    func test_routeToResults_showsResultsViewController() {
        let viewController = UIViewController()
        let results = Results.init(answers: [Question.singleSelection("Q1") : ["A1"]], score: 10)
        
        factory.stub(results: results, with: viewController)
        sut.routeTo(result: results)
        
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        
    }
    
    class NonAnimatingNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    
    class ViewControllerFacoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResults = [Results<Question<String>, [String]>: UIViewController]()
        var answerCallback = [Question<String>: ([String]) -> Void]()
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        func stub(results: Results<Question<String>, [String]>, with viewController: UIViewController) {
            stubbedResults[results] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func resultsViewController(for results: Results<Question<String>, [String]>) -> UIViewController {
            return stubbedResults[results] ?? UIViewController()
        }
    }
}

