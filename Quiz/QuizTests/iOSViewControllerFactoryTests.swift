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
     let options = ["A", "A2"]
    
    func test_questionViewController_singleSelection_createsQuestionControllerWithQuestion() {
        XCTAssertEqual(makeQuestionViewController(question: Question.singleSelection("Q1")).question, "Q1")
    }
    
    func test_questionViewController_singleSelection_createsQuestionControllerWithOptions() {
        XCTAssertEqual(makeQuestionViewController(question: Question.singleSelection("Q1")).options, options)
    }
    
    func test_questionViewController_singleSelection_createsQuestionControllerWithSingleSelection() {
        let controller = makeQuestionViewController(question: Question.singleSelection("Q1"))
        _ = controller.view
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    //MARK:- Helpers
    private func makeSUT(options: [Question<String> : [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
    
    private func makeQuestionViewController(question: Question<String> = Question.singleSelection("")) -> QuestionVC {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: {_ in }) as! QuestionVC
    }
    
    
}
