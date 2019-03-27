//
// HomeController.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 3/20/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {

    let celliD = "celliD"
    let menuController = MenuViewController()
    fileprivate let menuWidth: CGFloat = 300
    
    
    fileprivate func setupMenuController() {
        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height)
        
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuController.view)
        addChild(menuController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.red
        setupNavigationItems()
        
        setupMenuController()
    }
 
    
    //MARK:- Handle Open and Hide methods
    
    @objc func handleOpen() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,  initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.menuController.view.transform = CGAffineTransform(translationX: self.menuWidth, y: 0)
            
        })
    }
    
    @objc func handleHide() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,  initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.menuController.view.transform = .identity
            
        })
        
//        menuController.view.removeFromSuperview()
//        menuController.removeFromParent()
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

