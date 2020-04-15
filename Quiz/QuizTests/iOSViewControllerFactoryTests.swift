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

class iOSViewControllerFactoryTests: XCTestCase {
    func test_questionViewController_createsQuestionController() {
        let sut = iOSViewControllerFactory()
        let controller = sut.questionViewController(for: Question.singleSelection("Q1"), answerCallback: {_ in }) as! QuestionVC
        XCTAssertNotNil(controller)
    }
}
