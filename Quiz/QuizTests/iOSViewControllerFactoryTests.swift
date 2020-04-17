//
//  iOSViewControllerFactoryTests.swift
//  QuizTests
//
//  Created by Sergiu on 4/15/20.
//  Copyright © 2020 Sergiu. All rights reserved.Q
//

import UIKit
import XCTest
@testable import Quiz

class iOSViewControllerFactoryTests: XCTestCase {
    func test_questionViewController_singleSelection_createsQuestionControllerWithQuestion() {
        let question = Question.singleSelection("Q1")
        let options = ["A", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        
        let controller = sut.questionViewController(for: question, answerCallback: {_ in }) as! QuestionVC
        XCTAssertEqual(controller.question, "Q1")
    }
    
    func test_questionViewController_singleSelection_createsQuestionControllerWithOptions() {
        let question = Question.singleSelection("Q1")
        let options = ["A", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        
        let controller = sut.questionViewController(for: question, answerCallback: {_ in }) as! QuestionVC
        XCTAssertEqual(controller.options, options)
    }
    
    func test_questionViewController_singleSelection_createsQuestionControllerWithSingleSelection() {
        let question = Question.singleSelection("Q1")
        let options = ["A", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        
        let controller = sut.questionViewController(for: question, answerCallback: {_ in }) as! QuestionVC
        _ = controller.view
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
}
