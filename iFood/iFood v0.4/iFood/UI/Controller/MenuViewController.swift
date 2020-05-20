//
//  MenuViewController.swift
//  iFood
//
//  Created by Sergiu on 3/4/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit



class MenuViewController: UIViewController, UITableViewDelegate, Storyboarded {
    
    @IBOutlet weak var tableview: UITableView!
    
    let stateController = StateController()
    var cellAction: ((String)-> Void)?
    var menuDataSource: UITableViewDataSource? {
        didSet {
            tableview.dataSource = menuDataSource
            tableview.reloadData()
        }
    }
    
    var tableViewdelegate: UITableViewDelegate? {
        didSet {
            tableview.delegate = tableViewdelegate
        }
    }
    
    
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent(state: stateController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //MARK:- Loading helper methods
    private func loadContent(state: StateController) {
        let loadingController = LoadingViewController()
        add(loadingController)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            loadingController.remove()
            self?.menuDidLoad(state.items)
        }
         tableview.reloadData()
    }
    private func menuDidLoad(_ menu: [FoodCategory]) {
        menuDataSource = GenericDataSource.make(for: menu)
        tableViewdelegate = MenuDelegate(tableView: tableview, state: stateController, completion: { [weak self] title in
            self?.cellAction?(title)
        })
    }
}






extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(){
        guard parent != nil  else { return }
        willMove(toParent: parent)
        view.removeFromSuperview()
        removeFromParent()
    }
}




class LoadingViewController: UIViewController {
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = .lightGray
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        activityIndicator.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
                    self?.activityIndicator.startAnimating()
                }
    }
    
    
    func addSpinner() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        // Center our spinner both horizontally & vertically
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}
