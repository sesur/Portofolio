//
//  iOSViewControllerFactory.swift
//  Quiz
//
//  Created by Sergiu on 4/15/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    private let options: [Question<String> : [String]]
    private let correctAnswer: [Question<String>: [String]]
    private let questions: [Question<String>]
    
    init(question: [Question<String>], options: [Question<String> : [String]], correctAnswer: [Question<String>: [String]]) {
        self.options = options
        self.questions = question
        self.correctAnswer = correctAnswer
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = options[question] else {
            fatalError("Couldn't load options for question: \(question)")
        }
        return questionViewController(for: question, options: options, answerCallback: answerCallback)
    }
    
    func resultsViewController(for results: Results<Question<String>, [String]>) -> UIViewController {
        let presenter = ResultsPresenter(questions: questions, results: results, correctAnswer: correctAnswer)
        let controller = ResultsViewController(summary: presenter.summary, answers: presenter.presentableAnswer)
        controller.title = presenter.title
        return controller
       }
    
    
    
    
    //MARK: - Helpers
    
    private func questionViewController(for question: Question<String>, options: [String], answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleSelection(let value):
            return questionViewController(for: question, value: value, options: options, allowsMultipleSelection: false, answerCallback: answerCallback)
            
        case .multipleSelection(let value):
            return questionViewController(for: question, value: value, options: options, allowsMultipleSelection: true, answerCallback: answerCallback)
        }
    }
    
    private func questionViewController(for question: Question<String>, value: String, options: [String],allowsMultipleSelection: Bool, answerCallback: @escaping ([String]) -> Void) -> QuestionViewController {
        let presenter = QuestionPresenter(questions: questions, question: question)
        let viewController = QuestionViewController(question: value, options: options, allowsMultipleSelection: allowsMultipleSelection, selection: answerCallback)
        viewController.title = presenter.title
        return viewController
    }
}
