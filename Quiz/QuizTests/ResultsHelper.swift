//
//  ResultsHelper.swift
//  QuizTests
//
//  Created by Sergiu on 4/24/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
@testable import QuizEngine

extension Results: Hashable {
    static func make(answers: [Question: Answer] = [:], score: Int = 0 ) -> Results {
        return Results(answers: answers, score: score)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
    public static func ==(lhs: Results<Question, Answer>, rhs: Results<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
