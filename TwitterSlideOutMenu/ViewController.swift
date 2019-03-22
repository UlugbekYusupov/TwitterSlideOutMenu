//
//  ViewController.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 3/20/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let celliD = "celliD"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.red
        setupNavigationItems()
    }
    
    @objc func handleOpen() {
        
        let viewController = MenuViewController()
        
//        viewController.view.backgroundColor = .blue
        viewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 100, height: self.view.frame.height)
        
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(viewController.view)
        
//        view.addSubview(viewController.view)
        
//        let blueView = UIView()
//        blueView.backgroundColor = .blue
//        blueView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        view.addSubview(blueView)
        
    }
    
    @objc func handleHide() {
        
    }
    
    //MARK:- Setup Navigation Items
    fileprivate func setupNavigationItems() {
        
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }
    
    //MARK:- Setup TableView override methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: celliD)
        
        cell.textLabel?.text = "Row: \(indexPath.row)"
        
        return cell
    }
}

