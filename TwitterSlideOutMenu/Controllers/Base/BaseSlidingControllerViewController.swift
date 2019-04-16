//
//  BaseSlidingControllerViewController.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 4/4/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkCoverView: UIView {}


class BaseSlidingControllerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        setupViews()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    // MARK:- Instance Variables
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpen = false
    fileprivate let velocityThreshold: CGFloat = 500
    var redViewLeadingConstraint: NSLayoutConstraint!
    
    // MARK:- Red Blue Dark Views set up
    
    let redView: RightContainerView = {
        let v = RightContainerView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let blueView: MenuContainerView = {
        let v = MenuContainerView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let darkCoverView: DarkCoverView = {
        let v = DarkCoverView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // MARK:- Handle Pan Gestrues
    
    @objc func handlePan(gesture:UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpen ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0,x)
        
        redViewLeadingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpen {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            }
            else {
                closeMenu()
            }
        }
            
        else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            
            if translation.x < menuWidth / 2 {
                closeMenu()
            }
            else {
                openMenu()
            }
        }
    }
    
    func openMenu() {
        isMenuOpen = true
        redViewLeadingConstraint.constant = menuWidth
        performAnimations()
    }
    
    func closeMenu() {
        redViewLeadingConstraint.constant = 0
        isMenuOpen = false
        performAnimations()
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        
        performRightViewCleanUp()
        
        switch indexPath.row {
            
        case 0:
            print("Show Home Screen")
        case 1:
            let listsController = ListsController()
            redView.addSubview(listsController.view)
            addChild(listsController)
            rightViewController = listsController
            
        case 2:
            let bookmarksController = BookmarksController()
            redView.addSubview(bookmarksController.view)
            addChild(bookmarksController)
            rightViewController = bookmarksController
            
        default:
            print("Show Moments Screen")
        }
        
        redView.bringSubviewToFront(darkCoverView)
        
        closeMenu()
    }
    
    var rightViewController: UIViewController?
    
    fileprivate func performRightViewCleanUp() {
        rightViewController?.view.removeFromSuperview()
        rightViewController?.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpen ? 1 : 0
            
        })
    }
    
    // MARK:- Set up methods
    
    fileprivate func setupViews() {
        
        view.addSubview(redView)
        view.addSubview(blueView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.safeAreaLayoutGuide.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        self.redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        
//        let homeController = HomeController()
        let menuController = MenuViewController()
        
        rightViewController = HomeController()
        
        let homeView = rightViewController!.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        blueView.addSubview(menuView)
        redView.addSubview(homeView)
        redView.addSubview(darkCoverView)
        
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
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            
            // Dark Cover set up acnhors
            
            darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor)
            
            ])
        
        addChild(rightViewController!)
        addChild(menuController)
    }
}
