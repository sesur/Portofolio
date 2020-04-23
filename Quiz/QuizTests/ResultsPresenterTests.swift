//
//  ResultsPresenterTests.swift
//  QuizTests
//
//  Created by Sergiu on 4/24/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
import XCTest
import QuizEngine
@testable import Quiz

class ResultsPresenterTests: XCTestCase {
    func test_summary_withTwoQuestionsScoresOne_returnsSummary() {
        let answer = [Question.singleSelection("Q1"): ["A1"], Question.singleSelection("Q2"): ["A2"]]
        let result = Results.make(answers: answer, score: 1)
        let sut = ResultsPresenter(results: result, correctAnswer: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswer_withoutQuestion_isEmpty() {
        let answer = [Question<String>: [String]]()
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(results: result, correctAnswer: [:])
        XCTAssertTrue(sut.presentableAnswer.isEmpty)
    }
    
    func test_presentableAnswer_withWrongSingleAnswer_mapsAnswer() {
        let answer = [Question.singleSelection("Q1"): ["A1"]]
        let correctAnswer = [Question.singleSelection("Q1"): ["A2"]]
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(results: result, correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswer_withWrongMultipleAnswer_mapsAnswer() {
        let answer = [Question.multipleSelection("Q1"): ["A1", "A4"]]
        let correctAnswer = [Question.multipleSelection("Q1"): ["A2", "A3"]]
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(results: result, correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1, A4")
    }
    
}
