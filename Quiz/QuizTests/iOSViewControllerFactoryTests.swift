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
import QuizEngine

class iOSViewControllerFactoryTests: XCTestCase {
    let options = ["A", "A2"]
    let singleAnswerQuestion = Question.singleSelection("Q1")
    let multipleAnswerQuestion = Question.multipleSelection("Q1")
    
    func test_questionViewController_singleSelection_createsQuestionControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).title, presenter.title)
    }
    func test_questionViewController_singleSelection_createsQuestionControllerWithQuestion() {
        XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).question, "Q1")
    }
    
    func test_questionViewController_singleSelection_createsQuestionControllerWithOptions() {
        XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_singleSelection_createsQuestionControllerWithSingleSelection() {
        XCTAssertFalse(makeQuestionViewController(question: singleAnswerQuestion).allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleSelection_createsQuestionControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionViewController_multipleSelection_createsQuestionControllerWithQuestion() {
           XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).question, "Q1")
       }
    
    func test_questionViewController_multipleSelection_createsQuestionControllerWithOptions() {
        XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_multipleSelection_createsQuestionControllerWithMulltipleSelection() {
        XCTAssertTrue(makeQuestionViewController(question: multipleAnswerQuestion).allowsMultipleSelection)
    }
    
    func test_resultsViewController_createsViewController() {
        let answer = [Question<String>: [String]]()
        let results = Results.make(answers: answer, score: 0)
        let sut = makeSUT(options: [:])
        let controller = sut.resultsViewController(for: results) as! ResultsVC
        XCTAssertNotNil(controller)
    }
    
    //MARK:- Helpers
    private func makeSUT(options: [Question<String> : [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(question: [singleAnswerQuestion, multipleAnswerQuestion], options: options)
    }
    
    private func makeQuestionViewController(question: Question<String> = Question.singleSelection("")) -> QuestionVC {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: {_ in }) as! QuestionVC
    }
    
    
}
