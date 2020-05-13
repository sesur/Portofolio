//
//  QuestionPresenter.swift
//  Quiz
//
//  Created by Sergiu on 4/28/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
import QuizEngine

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>
    
    var title: String {
        guard let index = questions.firstIndex(of: question) else {return "" }
        return "Question #\(index + 1 )"
    }
}
