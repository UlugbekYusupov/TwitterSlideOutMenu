//
//  ListsController.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 4/15/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class ListsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Lists"
        navigationController?.navigationBar.prefersLargeTitles = true
        let listLabel = UILabel()
        listLabel.text = "Lists"
        listLabel.font = UIFont.boldSystemFont(ofSize: 64)
        listLabel.frame = view.frame
        listLabel.textAlignment = .center
        
        view.backgroundColor = .white
        
        view.addSubview(listLabel)
    }

}
