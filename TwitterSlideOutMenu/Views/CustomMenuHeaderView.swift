//
//  CustomMenuHeaderView.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 4/9/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    
    // MARK:- UILabels and UIImageView
    
    let nameLabel = UILabel()
    let userNameLabel = UILabel()
    let statsLabel = UILabel()
    let profileImageView = ProfileImageView()
    
    // MARK:- init and required init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        setupComponentProps()
        setupStackViewAnchors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Setup methods
    
    fileprivate func setupStackViewAnchors() {
        
        let arrangedSubviews = [
//            UIView(),
            // to get image to the right side using UIview on the right of newly creadet stackView
            UIStackView(arrangedSubviews: [profileImageView, UIView()]),
            nameLabel,
            userNameLabel,
            SpacerView(space: 20),
            statsLabel
        ]
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        
        // setting up stackView anchors
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    fileprivate func setupComponentProps() {
        
        nameLabel.text = "Yusupov Ulugbek"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        userNameLabel.text = "@buildthatapp"
        statsLabel.text = "42 Following 7091 Followers"
        
        profileImageView.image = #imageLiteral(resourceName: "me")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .red
        
        setupStatsAttributedText()
    }
    
    fileprivate func setupStatsAttributedText() {
        
        statsLabel.font = UIFont.systemFont(ofSize: 14)
        
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        
        attributedText.append(NSAttributedString(string: "Following  ", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]))
        
        attributedText.append(NSAttributedString(string: "Followers", attributes: [.foregroundColor: UIColor.black]))
        
        statsLabel.attributedText = attributedText
    }
}
