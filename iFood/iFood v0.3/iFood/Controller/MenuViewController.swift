//
//  MenuViewController.swift
//  iFood
//
//  Created by Sergiu on 3/4/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Storyboarded {
    
    @IBOutlet weak var tableview: UITableView!
    
    var cellAction: ((String)-> Void)?
    var data = DataSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellCategory") as! CategoryCell
        cell.wrapperCell = data.categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let categorySelectedItem = data.categories[indexPath.row].title
        cellAction?(categorySelectedItem.rawValue)
    }
}

