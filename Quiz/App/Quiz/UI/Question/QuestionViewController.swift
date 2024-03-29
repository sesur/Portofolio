//
//  QuestionViewController.swift
//  Quiz
//
//  Created by Sergiu on 10/25/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private (set) var question = ""
    private (set) var options = [String]()
    private (set) var allowsMultipleSelection = false
    private var selection: (([String]) -> Void)? = {_ in}
    private let cellId = "CellId"
    
    convenience init(question: String, options: [String], allowsMultipleSelection: Bool, selection: @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.allowsMultipleSelection = allowsMultipleSelection
        self.selection = selection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerLabel.text = question
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsMultipleSelection = allowsMultipleSelection
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
             selection?(selectedOptions(in: tableView))
        }
    }
    
  
    
    //MAR:- Helpers
    
    private func selectedOptions(in tableView: UITableView) -> [String] {
        guard let indexPath = tableView.indexPathsForSelectedRows else {return [] }
        return indexPath.map { options[$0.row] }
    }
    
}

extension QuestionViewController {
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: cellId)
    }
}
