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
    let questions: [Question<String>]
    let results: Results<Question<String>, [String]>
    let correctAnswer: [Question<String>: [String]]
    
    var title: String {
        return "Result" 
    }
    
    var summary: String {
        return "You got \(results.score)/\(results.answers.count) correct"
    }
    
    var presentableAnswer: [PresentableAnswer] {
        return questions.map { question in
            guard let userAnswer = results.answers[question], let correctAnswer = correctAnswer[question] else {
                fatalError("Couldn't load answer for question: \(question)")
            }
            return presentableAnswer(question, userAnswer, correctAnswer)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
        
        switch question {
        case .singleSelection(let value), .multipleSelection(let value):
            return PresentableAnswer(question: value,
                                     answer: formattedRightAnswer(correctAnswer),
                                     wrongAnswer: formattedWrongAnswer(userAnswer, correctAnswer))
        }
    }
    
    private func formattedRightAnswer(_ answer: [String]) -> String {
        return answer.joined(separator: ", ")
    }
    
    private func formattedWrongAnswer(_ userAnswer: [String],
                                      _ correctAnswer: [String]) -> String? {
        return correctAnswer == userAnswer ? nil : formattedRightAnswer(userAnswer)
    }
}
