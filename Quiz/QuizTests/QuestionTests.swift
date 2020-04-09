//
//  QuestionTests.swift
//  QuizTests
//
//  Created by Sergiu on 4/9/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
import XCTest
@testable import Quiz

class QuestionTests: XCTestCase {
    func test_singleSelection_returnHashValue() {
        let type = "type"
        let sut = Question.singleSelection(type)
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_multipleSelection_returnHashValue() {
        let type = "type"
        let sut = Question.singleSelection(type)
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_equal_isEqual() {
        XCTAssertEqual(Question.singleSelection("a string"), Question.singleSelection("a string"))
        XCTAssertEqual(Question.multipleSelection("a string"), Question.multipleSelection("a string"))
    }
    
    func test_notEqual_isNotEqual() {
        XCTAssertNotEqual(Question.singleSelection("aa string"), Question.singleSelection("a string"))
        XCTAssertNotEqual(Question.multipleSelection("aa string"), Question.multipleSelection("a string"))
        XCTAssertNotEqual(Question.singleSelection("aa string"), Question.multipleSelection("a string"))
        XCTAssertNotEqual(Question.singleSelection("a string"), Question.multipleSelection("a string"))
    }
}
