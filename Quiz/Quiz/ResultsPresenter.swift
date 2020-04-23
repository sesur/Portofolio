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
    
    var summary: String {
        return "You got \(results.score)/\(results.answers.count) correct"
    }
}
