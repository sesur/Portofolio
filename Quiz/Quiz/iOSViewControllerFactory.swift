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
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
        return QuestionVC()
    }
    
    func resultsViewController(for results: Results<Question<String>, String>) -> UIViewController {
        return UIViewController()
    }
    
    
}
