//
//  CustomMenuHeaderView.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 4/9/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        
        let nameLabel = UILabel()
        nameLabel.text = "Yusupov Ulugbek"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        let userNameLabel = UILabel()
        userNameLabel.text = "@buildthatapp"
        
        let statsLabel = UILabel()
        statsLabel.text = "42 Following 7091 Followers"
        
        //this is spacing hack with UIViews
        let arrangedSubviews = [UIView(),nameLabel, userNameLabel, SpacerView(space: 24),	statsLabel]
        
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        setupStackViewAnchors(stackView: stackView)
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupStackViewAnchors(stackView: UIStackView) {
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
