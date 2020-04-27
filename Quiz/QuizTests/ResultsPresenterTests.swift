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
        let sut = ResultsPresenter(questions: [Question.singleSelection("Q1"), Question.multipleSelection("Q2")], results: result, correctAnswer: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswer_withoutQuestion_isEmpty() {
        let answer = [Question<String>: [String]]()
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(questions: [], results: result, correctAnswer: [:])
        XCTAssertTrue(sut.presentableAnswer.isEmpty)
    }
    
    func test_presentableAnswer_withWrongSingleAnswer_mapsAnswer() {
        let answer = [Question.singleSelection("Q1"): ["A1"]]
        let correctAnswer = [Question.singleSelection("Q1"): ["A2"]]
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(questions: [Question.singleSelection("Q1")], results: result, correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswer_withWrongMultipleAnswer_mapsAnswer() {
        let answer = [Question.multipleSelection("Q1"): ["A1", "A4"]]
        let correctAnswer = [Question.multipleSelection("Q1"): ["A2", "A3"]]
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(questions: [Question.multipleSelection("Q1")], results: result, correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswer_withRightSingleAnswer_mapsAnswer() {
        let answer = [Question.singleSelection("Q1"): ["A2"]]
        let correctAnswer = [Question.singleSelection("Q1"): ["A2"]]
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(questions: [Question.singleSelection("Q1")], results: result, correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
    }
    
    func test_presentableAnswer_withRightMultipleAnswer_mapsAnswer() {
        let answer = [Question.multipleSelection("Q1"): ["A2", "A3"]]
        let correctAnswer = [Question.multipleSelection("Q1"): ["A2", "A3"]]
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(questions: [Question.multipleSelection("Q1")], results: result, correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
    }
    
    func test_presentableAnswer_withTwoQuestions_mapsOrderedAnswer() {
        let answer = [Question.multipleSelection("Q2"): ["A2", "A3"], Question.multipleSelection("Q1"): ["A1"]]
        let correctAnswer = [Question.multipleSelection("Q1"): ["A1"], Question.multipleSelection("Q2"): ["A2", "A3"]]
        let orderedQuestion = [Question.multipleSelection("Q1"), Question.multipleSelection("Q2")]
        
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(questions: orderedQuestion, results: result, correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 2)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswer.last!.answer, "A2, A3")
        XCTAssertNil(sut.presentableAnswer.last!.wrongAnswer)
    }
    
}
