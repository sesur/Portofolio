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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

