//
//  ContentListDataSource.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/9/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import UIKit

class ContentListDataSource: NSObject, UITableViewDataSource {
    
    var dataSourceInSections = [[Content]]()
    
    //Separate by type into a new dic.
    var dataSource: [Content]? {
        didSet {
            if let dataSource = dataSource {
                for type in ContentType.allCases {
                    dataSourceInSections.append(dataSource.filter({ $0.type == type}))
                }
            }
        }
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceInSections[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceInSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return ContentType.allCases.map({  NSLocalizedString( $0.rawValue, comment: "Localized the enum for the type." )} )[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //I'm using the TextTableViewCell for both text and other type, because the there is one other type and it's text.
        if dataSourceInSections[indexPath.section][indexPath.row].type == .Image {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageTableViewCell.self)", for: indexPath) as? ImageTableViewCell
            cell?.data = dataSourceInSections[indexPath.section][indexPath.row]
            return cell!
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TextTableViewCell.self)", for: indexPath) as? TextTableViewCell
            cell?.data = dataSourceInSections[indexPath.section][indexPath.row]
            return cell!
        }
    }
}
