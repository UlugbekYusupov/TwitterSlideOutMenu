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
        
        x = isMenuOpen ? x + menuWidth : x
        
        x = min(menuWidth, x)
        redViewLeadingConstraint.constant = x
        
        handleEnded(gesture: gesture)
        
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
    
        if translation.x < menuWidth / 2 {
            redViewLeadingConstraint.constant = 0
            isMenuOpen = false
        }
        else {
            isMenuOpen = true
            redViewLeadingConstraint.constant = menuWidth
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
            
        })
    }
    
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpen = false
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
        redViewLeadingConstraint.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        
        let homeController = HomeController()
        let menuController = MenuViewController()
        
        let homeView = homeController.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        blueView.addSubview(menuView)
        redView.addSubview(homeView)
        
        
        NSLayoutConstraint.activate([
            
            // HomeView set up anchors
            
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            
            // Menu View set up anchors
            
            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor)
            ])
        
        addChild(homeController)
        addChild(menuController)
    }
}
