//
//  ResultsPresenter.swift
//  Quiz
//
//  Created by Sergiu on 4/24/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
import QuizEngine

struct ResultsPresenter {
    let results: Results<Question<String>, [String]>
    let correctAnswer: [Question<String>: [String]]
    
    var summary: String {
        return "You got \(results.score)/\(results.answers.count) correct"
    }
    
    var presentableAnswer: [PresentableAnswer] {
        return results.answers.map { (question, userAnswer) in
            guard let correctAnswer = correctAnswer[question] else {
                fatalError("Couldn't load answer for question: \(question)")
            }
            
            switch question {
            case .singleSelection(let value), .multipleSelection(let value):
                return PresentableAnswer(question: value, answer: correctAnswer.first!, wrongAnswer: userAnswer.first!)
            }
        }
    }
}
