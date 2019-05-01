//
//  ChatroomsMenuController.swift
//  TwitterSlideOutMenu
//
//  Created by Ulugbek Yusupov on 4/20/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

extension ChatroomsMenuController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        if searchText.isEmpty {
            filteredResults = chatroomGroups
            tableView.reloadData()
            return
        }
        
//        var results = [[String]]()
//        chatroomGroups.forEach { (group) in
//            let filteredGroup = group.filter({ (chatromName) -> Bool in
//                return chatromName.lowercased().contains(searchText.lowercased())
//
//            })
//            results.append(filteredGroup)
//        }
//        filteredResults = results
        
        filteredResults = chatroomGroups.map({ (group) -> [String] in
            return group.filter { $0.lowercased().contains(searchText.lowercased())}
        })
        
        tableView.reloadData()
    }
}

class ChatroomsMenuController: UITableViewController {

    let chatroomGroups = [
        ["general", "indtroduction"],
        ["jobs"],
        ["Ulugbek", "Steve Jobs", "Bill Gates", "Barack Obama"]
    ]
    
    var filteredResults = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredResults = chatroomGroups
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
    }

    
    //MARK:- TableView cell and section Setup
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "UNREADS" : section == 1 ? "CHANNELS" : "DIRECT MESSAGE"
    }
    
    fileprivate class ChatroomHeaderLabel: UILabel {
        
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.insetBy(dx: 16, dy: 0))
            
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredResults.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults[section].count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let text = section == 0 ? "UNREADS" : section == 1 ? "CHANNELS" : "DIRECT MESSAGE"
        let label = ChatroomHeaderLabel()
        label.text = text
        label.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
        label.textColor = #colorLiteral(red: 0.4520682693, green: 0.4062769711, blue: 0.526714325, alpha: 1)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatroomMenuCell(style: .default, reuseIdentifier: nil)
        
        let text = filteredResults[indexPath.section][indexPath.row]
        cell.textLabel?.text = text
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        let attributedText = NSMutableAttributedString(string: "#  ", attributes: [.foregroundColor: #colorLiteral(red: 0.4520682693, green: 0.4062769711, blue: 0.526714325, alpha: 1), .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        attributedText.append(NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.white]))
        
        cell.textLabel?.attributedText = attributedText
        
        return cell
    }
}
