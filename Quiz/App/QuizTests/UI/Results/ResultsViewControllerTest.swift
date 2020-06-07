//
//  ResultsViewControllerTest.swift
//  QuizTests
//
//  Created by Sergiu on 11/1/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import XCTest
@testable import Quiz

class ResultsViewControllerTest: XCTestCase {
    func test_viewDidLoad_headerlabel() {
        XCTAssertEqual(makeSUT(summary: "a summary").headerLabel.text, "a summary")
    }
    
    func test_viewDidLoad_rendersAnswer() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(answers: [makeAnswer(), makeAnswer()]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    //CorectAnswer cell
    func test_viewDidLoad_correctAnswer_rconfigureCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1")
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(atRow: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
  
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    
    //WrongAnswer cell
    func test_viewDidLoad_wrongAnswerCell_configureCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong")
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(atRow: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
        
    }


    
    //MARK:- Helpers
    
    private func makeSUT(summary: String = "",answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    private func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil) -> PresentableAnswer {
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }
    
}

