//
//  GenericTableviewControler.swift
//  iFood
//
//  Created by Sergiu on 7/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class GenericTableview<T: GenericCell<U>, U> : UIViewController, UITableViewDelegate, UITableViewDataSource, Storyboarded {
    
    let cellId = "cellCategory"
    var itemsArray: [U] = [] {
        didSet {
            print("Data changed")
        }
    }
    
    var cellAction: ((String)-> Void)?

    
    @IBOutlet weak var tableview: UITableView!
//    var data = DataSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(T.self, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellId) as! GenericCell<U>
        cell.item = itemsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let categorySelectedItem = itemsArray[indexPath.row].title.rawValue
//        cellAction?(categorySelectedItem )
    }
}



