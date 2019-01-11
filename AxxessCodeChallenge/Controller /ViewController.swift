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
        tableView.separatorStyle = .none
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
            else {
                
                let alert = UIAlertController(title: NSLocalizedString("No connection", comment: ""), message: NSLocalizedString("Check if you are connected to the internet.", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: NSLocalizedString("Try again", comment: ""), style: .default, handler:{ _ in
                        //Call the network again.
                        self.networkCall()
                    }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func setupView() {
        self.title = "Axxess challenge"
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = datasource
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 10
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Deselect the row to remove the gray background color.
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = DetailViewController()
        vc.data = datasource.dataSourceInSections[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
