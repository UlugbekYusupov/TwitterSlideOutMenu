//
//  MenuViewController.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 3/20/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

struct MenuItem {
    
    let icon: UIImage
    let title: String
    
}

extension MenuViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // accessing BaseSlidingController.closeMenu()
        let slidingController = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingControllerViewController
        slidingController?.didSelectMenuItem(indexPath: indexPath)
        
    }
}

class MenuViewController: UITableViewController {
    
    let menuItems = [
        MenuItem(icon: #imageLiteral(resourceName: "profile"), title: "Home"),
        MenuItem(icon: #imageLiteral(resourceName: "lists"), title: "Lists"),
        MenuItem(icon: #imageLiteral(resourceName: "bookmarks"), title: "Bookmarks"),
        MenuItem(icon: #imageLiteral(resourceName: "moments"), title: "Moments")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none // removes the lines between cells in tableView
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let customeHeaderView = CustomMenuHeaderView()
        
        return customeHeaderView
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuItem = menuItems[indexPath.row]
        let cell = MenuCell(style: .default, reuseIdentifier: "celliD")
        
        cell.iconImageView.image = menuItem.icon
        cell.title.text = menuItem.title
        
        return cell
    }
}
