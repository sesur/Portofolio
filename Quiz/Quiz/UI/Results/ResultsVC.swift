//
//  ResultsVC.swift
//  Quiz
//
//  Created by Sergiu on 11/1/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit

class ResultsVC: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    private (set) var summary = ""
    private (set) var answers = [PresentableAnswer]()
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = summary
        
        tableView.dataSource = self
        tableView.register(for: CorrectAnswerCell.self)
        tableView.register(for: WrongAnswerCell.self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if  answer.wrongAnswer == nil {
            return corectAnswerCell(for: answer)
        }
        return wrongCellAnswer(for: answer)
    }
    
    //MARK:- Helpers
    private func corectAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)!
        cell.answerLabel.text = answer.answer
        cell.questionLabel.text = answer.question
        return cell
    }
    
    private func wrongCellAnswer(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WrongAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }
    
}
