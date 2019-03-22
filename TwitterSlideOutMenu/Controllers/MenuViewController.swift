//
//  MenuViewController.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 3/20/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    let celliD = "celliD"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .yellow
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: celliD)
        cell.textLabel?.text = "Menu Item for Row \(indexPath.row)"
        
        return cell
    }
}
