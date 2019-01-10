//
//  ViewController.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/8/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    var datasource = ContentListDataSource()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        //Using the class name as the Reuse Identifier.
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "\(ImageTableViewCell.self)")
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: "\(TextTableViewCell.self)")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.networkCall()
    }
    
    private func networkCall() {
        Network.request(endpoint: .Challenge) { (content: [Content]?) in
            if let content = content {
                self.datasource.dataSource = content
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupView() {
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = datasource
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 10
        tableView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}
