//
//  QuestionVCTest.swift
//  QuizTests
//
//  Created by Sergiu on 10/25/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import XCTest
@testable import Quiz



class QuestionVCtest: XCTestCase {
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
        let sut = makeSUT(options: ["A1", "A2"]) {
            selectedAnser = $0
        }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(selectedAnser, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(selectedAnser, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifieWthEmptySelection() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"]) { _ in callbackCount += 1 }
        
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionSelected_withMultipleSelection_notifiesDelegated() {
        var selectedAnser = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) {
            selectedAnser = $0
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(selectedAnser, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(selectedAnser, ["A1", "A2"])
    }
    
    func test_optionDeselected_withMultipleSelection_notifiesDelegated() {
        var selectedAnser = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) {
            selectedAnser = $0
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(selectedAnser, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(selectedAnser, [])
    }
    
    
    
    
    
    //MARK:- Helpers
    private func makeSUT(question: String = "",
                         options: [String] = [],
                         selection: @escaping ([String]) -> Void = {_ in} ) -> QuestionVC {
        let sut = QuestionVC(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
}




//
//class QuestionVCtest: XCTestCase {
//    func test_viewDidLoad_withHeaderText() {
//        let sut = QuestionVC(question:"Q1", options:[])
//        _ = sut.view
//        XCTAssertEqual(sut.headerLabel.text, "Q1")
//    }
//
//    func test_viewDidLoad_WithNoOption_rendersZeroOptios() {
//        let sut = QuestionVC(question:"Q1", options: [])
//        _ = sut.view
//        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0 ), 0)
//    }
//
//    func test_viewDidLoad_WithOneOption_rendersOneOptios() {
//        let sut = QuestionVC(question:"Q1", options: ["A1"])
//        _ = sut.view
//        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0 ), 1)
//    }
//
//    func test_viewDidLoad_WithOneOption_rendersOneOptiosText() {
//        let sut = QuestionVC(question:"Q1", options: ["A1"])
//        _ = sut.view
//
//        let indexPath = IndexPath(row: 0, section: 0)
//        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
//
//        XCTAssertEqual(cell?.textLabel?.text, "A1")
//    }
//}
