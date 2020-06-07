//
//  QuestionViewControllerTest.swift
//  QuizTests
//
//  Created by Sergiu on 10/25/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import XCTest
@testable import Quiz



class QuestionViewControllerTest: XCTestCase {
    func test_viewDidLoad_withHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_rendersOptiosText() {
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(atRow: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(atRow: 1), "A2")
        XCTAssertEqual(makeSUT(options: ["A1", "A2", "A3"]).tableView.title(atRow: 2), "A3")
    }
    
    
    func test_optionSelected_withSingleSelection_notifiesDelegates() {
        var selectedAnser = [String]()
        let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: false) {
            selectedAnser = $0
        }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(selectedAnser, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(selectedAnser, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifieWthEmptySelection() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: false) { _ in callbackCount += 1 }
        
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionSelected_withMultipleSelection_notifiesDelegated() {
        var selectedAnser = [String]()
        let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: true) {
            selectedAnser = $0
        }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(selectedAnser, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(selectedAnser, ["A1", "A2"])
    }
    
    func test_optionDeselected_withMultipleSelection_notifiesDelegated() {
        var selectedAnser = [String]()
        let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: true) {
            selectedAnser = $0
        }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(selectedAnser, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(selectedAnser, [])
    }
    
    
    
    
    //MARK:- Helpers
    private func makeSUT(question: String = "",
                         options: [String] = [],
                         allowsMultipleSelection: Bool = false,
                         selection: @escaping ([String]) -> Void = {_ in} ) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, allowsMultipleSelection: allowsMultipleSelection, selection: selection)
        _ = sut.view
        return sut
    }
}




