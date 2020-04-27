//
//  QuestionPresenterTests.swift
//  QuizTests
//
//  Created by Sergiu on 4/28/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
import XCTest
@testable import Quiz

class QuestionPresenterTests: XCTestCase {
    
    let question1 = Question.singleSelection("A1")
    let question2 = Question.singleSelection("A2")
    
    func test_title_forFirstQuestion() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question1)
        XCTAssertEqual(sut.title, "Question #1")
    }
    func test_title_forSecondQuestion() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question2)
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forNonExistingQuestions_isEmpty() {
        let sut = QuestionPresenter(questions: [], question: question1)
        XCTAssertEqual(sut.title, "")
    }
}
