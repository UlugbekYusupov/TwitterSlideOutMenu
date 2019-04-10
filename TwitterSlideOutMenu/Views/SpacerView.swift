//
//  SpacerView.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 4/9/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//


// to make custom spacing class to space contents in the view
import UIKit

class SpacerView: UIView {

    let space: CGFloat
    
    override var intrinsicContentSize: CGSize {
        return .init(width: space, height: space)
    }

    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
