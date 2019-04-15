//
//  BookmarksController.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 4/15/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class BookmarksController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Bookmarks: \(indexPath.row)"

        return cell
    }

}
