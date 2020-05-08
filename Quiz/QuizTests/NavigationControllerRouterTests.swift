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
    let singleAnswerQuestion = Question.singleSelection("Q1")
    let multipleAnswerQuestion = Question.multipleSelection("Q2")
    
    let navigationController = NonAnimatingNavigationController()
    let factory = ViewControllerFacoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(navigationController, factory: factory)
    }()
    
    func test_routeToSecondQuestion_showsViewController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        factory.stub(question: multipleAnswerQuestion, with: secondViewController)
        
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToSecondQuestion_singleAnswer_answerCallback_progressToNextQuestion() {
        var answerCallBackFired = false
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in answerCallBackFired = true })
        factory.answerCallback[singleAnswerQuestion]!(["anything"])
        XCTAssertTrue(answerCallBackFired)
    }
    func test_routeToSecondQuestion_singleAnswer_doeNotConfiguresViewControllerWithSubmittButton() {
        let viewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in})
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    
    func test_routeToSecondQuestion_multipleAnswer_answerCallback_doeNotProgressToNextQuestion() {
        var answerCallBackFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in answerCallBackFired = true })
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertFalse(answerCallBackFired)
    }
    
    func test_routeToSecondQuestion_multipleAnswer_configuresViewControllerWithSubmittButton() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in})
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem!)
    }
    
    func test_routeToSecondQuestion_multipleAnswerSubmitButton_isDisableWhenZeroAnswerSelected() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in})
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_routeToSecondQuestion_multipleAnswerSubmitButton_progressToNextQuestion() {
        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        var callBackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in callBackWasFired = true })
        factory.answerCallback[ multipleAnswerQuestion]!(["anything"])
        
        viewController.navigationItem.rightBarButtonItem?.simulateTap()        
        XCTAssertTrue(callBackWasFired)
    }
    
    
    
    //ResultViewController
    func test_routeToResults_showsResultsViewController() {
        let viewController = UIViewController()
        let results = Results.init(answers: [singleAnswerQuestion : ["A1"]], score: 10)
        
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

private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}

