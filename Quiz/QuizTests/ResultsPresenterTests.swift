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
    let singleAnswerQuestion = Question.singleSelection("Q1")
    let multipleAnswerQuestion = Question.multipleSelection("Q2")
    
    func test_summary_withTwoQuestionsScoresOne_returnsSummary() {
        let answer = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A2","A3"]]
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
        let answer = [singleAnswerQuestion: ["A1"]]
        let correctAnswer = [singleAnswerQuestion: ["A2"]]
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(questions: [singleAnswerQuestion], results: result, correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswer_withWrongMultipleAnswer_mapsAnswer() {
        let answer = [multipleAnswerQuestion: ["A1", "A4"]]
        let correctAnswer = [multipleAnswerQuestion: ["A2", "A3"]]
        let result = Results.make(answers: answer)
        let sut = ResultsPresenter(questions: [multipleAnswerQuestion], results: result, correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswer_withTwoQuestions_mapsOrderedAnswer() {
        let answer = [multipleAnswerQuestion: ["A2", "A3"], singleAnswerQuestion: ["A1"]]
        let correctAnswer = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A2", "A3"]]
        let orderedQuestion = [singleAnswerQuestion, multipleAnswerQuestion]
        
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
