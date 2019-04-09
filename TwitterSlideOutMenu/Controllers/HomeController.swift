//
// HomeController.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 3/20/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class HomeController: UITableViewController, UIGestureRecognizerDelegate {

    let celliD = "celliD"
    let menuController = MenuViewController()
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpened = false
    fileprivate let velocityOpenThreshold: CGFloat = 500
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.red
        setupNavigationItems()
        setupMenuController()
//        setupPanGesture()
        setupDarkCoverView()
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        menuController.view.frame = CGRect(x: 0, y: 0, width: 200, height: 500)
//    }
   
    //MARK:- Handle Open and Hide methods
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .changed {
            handleChanged(gesture: gesture)
        }
        else if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    
    @objc func handleOpen() {
        isMenuOpened = true
        performAnimations(transform:  CGAffineTransform(translationX: self.menuWidth, y: 0))
    }
    
    @objc func handleHide() {
        isMenuOpened = false
        performAnimations(transform: .identity)
    }
    
    //MARK: - Fileprivate
    let darkCoverView = UIView()
    
    fileprivate func setupDarkCoverView() {
        
        darkCoverView.alpha = 0
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        darkCoverView.isUserInteractionEnabled = false
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(darkCoverView)
        darkCoverView.frame = mainWindow?.frame ?? .zero
    }
    
    fileprivate func setupPanGesture() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGesture.delegate = self
        
        self.view.addGestureRecognizer(panGesture)
    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//
//        return true
//    }
    
    fileprivate func handleChanged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)

        var x = translation.x
        
        if isMenuOpened {
            x += menuWidth
        }
        
        x = min(menuWidth,x)
        x = max(0,x)
        
        let transform = CGAffineTransform(translationX: x, y: 0)
        
        menuController.view.transform = transform
        navigationController?.view.transform = transform
        darkCoverView.transform = transform
        
        darkCoverView.alpha = x / menuWidth
        
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
            
            if abs(velocity.x) > velocityOpenThreshold {
                handleHide()
                return
            }
            
            if abs(translation.x) < menuWidth / 2 {
                handleOpen()
            }
            else {
                handleHide()
            }
            
        }
        else {
            
            if velocity.x > velocityOpenThreshold {
                handleOpen()
                return
            }
            
            if translation.x < menuWidth / 2 {
                handleHide()
            }
            else {
                handleOpen()
            }
        }
        
    }
    
    fileprivate func performAnimations(transform: CGAffineTransform) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1,  initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.menuController.view.transform = transform
            self.navigationController?.view.transform = transform
            self.darkCoverView.transform = transform
            self.darkCoverView.alpha = transform == .identity ? 0 : 1
//
//            if transform == .identity {
//                self.darkCoverView.alpha = 0
//            } else {
//                self.darkCoverView.alpha = 1
//            }
        })
        
    }
    
    fileprivate func setupMenuController() {
        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height)
        
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuController.view)
        addChild(menuController)
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

