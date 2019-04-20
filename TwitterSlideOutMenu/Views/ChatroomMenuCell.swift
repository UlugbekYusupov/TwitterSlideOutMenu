//
//  ChatroomMenuCell.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 4/20/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class ChatroomMenuCell: UITableViewCell {

    let bgView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        v.layer.cornerRadius = 5
        return v
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        addSubview(bgView)
        
        bgView.fillSuperview(padding: .init(top: 0, left: 4, bottom: 0, right: 4))
        
        sendSubviewToBack(bgView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        bgView.isHidden = !selected
//        contentView.backgroundColor = selected ? .orange : .clear
        
     }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
