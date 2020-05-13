//
//  AppDelegate.swift
//  Quiz
//
//  Created by Sergiu on 10/25/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit
import QuizEngine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let question1 = Question.multipleSelection("What is the nationality of Sergiu")
        let question2 = Question.singleSelection("What is the nationality of Teo")
        let questions = [question1, question2]
        
        let option1 = "Moldovan"
        let option2 = "American"
        let option3 = "Romanian"
        let options1 = [option1, option2, option3]
        
        
        let option4 = "Canadian"
        let option5 = "Greek"
        let option6 = "Moldovan"
        let options2 = [option4, option5, option6]
        
        let correctAnswers = [question1 : [option1, option3], question2: [option6]]
        
        let navigationController = UINavigationController()
        let factory = iOSViewControllerFactory(question: questions, options: [question2: options2, question1 : options1], correctAnswer: correctAnswers)
        let router = NavigationControllerRouter(navigationController, factory: factory)
        
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        game = startGame(questions: questions, router: router, correctAnswers: correctAnswers)
        
        return true
    }

}

