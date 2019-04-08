//
//  BaseSlidingControllerViewController.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 4/4/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class BaseSlidingControllerViewController: UIViewController {
    
    let redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let blueView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        setupViews()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(gesture:UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = min(menuWidth, x)
        redViewLeadingConstraint.constant = x
        
    }
    
    fileprivate let menuWidth: CGFloat = 300
    fileprivate func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        self.redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
//        redViewLeadingAnchor.constant = 150
        redViewLeadingConstraint.isActive = true
    }
}
