//
//  TextTableViewCell.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/9/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    var data: Content? {
        didSet {
            contentLabel.text = data?.data
            setupView()
        }
    }
    
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private func setupView() {
        self.contentView.addSubview(contentLabel)
            
        contentLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.contentView)
            make.leadingMargin.equalTo(self.contentView).offset(10)
            make.trailingMargin.equalTo(self.contentView)
            make.bottomMargin.equalTo(self.contentView).offset(-50)
        }
        
        //If date is avalable add the date label.
        if let date = data?.date {
            self.contentView.addSubview(dateLabel)
            dateLabel.text = Date.dateFormat(date: date)
            dateLabel.snp.makeConstraints { (make) in
                make.trailingMargin.equalTo(self.contentView).offset(-5)
                make.bottomMargin.equalTo(self.contentView).offset(-15)
            }
        }
    }
}

