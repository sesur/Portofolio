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
        let sut = ResultsPresenter(results: result)
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_summary_withTwoQuestionsScoresTwo_returnsSummary() {
        let answer = [Question.singleSelection("Q1"): ["A1"], Question.singleSelection("Q2"): ["A2"]]
        let result = Results.make(answers: answer, score: 2)
        let sut = ResultsPresenter(results: result)
        XCTAssertEqual(sut.summary, "You got 2/2 correct")
    }
}
