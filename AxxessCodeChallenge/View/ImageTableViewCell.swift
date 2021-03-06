//
//  ImageTableViewCell.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/9/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageTableViewCell: UITableViewCell {
    
    var data: Content? {
        didSet {
            self.getImage()
        }
    }
    
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var noContentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.lightGray
        label.text = NSLocalizedString("Could not load content.", comment: "")
        return label
    }()
    
    let contentImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        self.setupView()
    }
    
    private func setupView() {
        self.contentView.addSubview(contentImageView)
        
        //Display the imageview with a fix hight of 350
        //This is done to keep the UI consistent
        contentImageView.snp.makeConstraints { (make) in
            make.height.equalTo(350)
            make.topMargin.equalTo(self.contentView)
            make.leadingMargin.equalTo(self.contentView)
            make.trailingMargin.equalTo(self.contentView)
            make.bottomMargin.equalTo(self.contentView).offset(-50).priority(999)
        }
        
        //If date is available add the date label.
        if let date = data?.date {
            self.contentView.addSubview(dateLabel)
            dateLabel.text = Date.dateFormat(date: date)
            dateLabel.snp.makeConstraints { (make) in
                //Display the label in the right corner of the cell.
                make.trailingMargin.equalTo(self.contentView).offset(-5)
                make.bottomMargin.equalTo(self.contentView).offset(-15)
            }
        }
    }
    
    //Download image using the alamofireImage imageview extension
    private func getImage() {
        //Reset imageview, date label and no content label. This is needed because the cell is reused.
        self.noContentLabel.removeFromSuperview()
        self.dateLabel.removeFromSuperview()
        contentImageView.image = nil
        
        guard let data = data?.data,
            let url =  URL(string: data) else { return }
        //Use AlamofireImage to populate the imageView
        contentImageView.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.8), runImageTransitionIfCached: false, completion: { (response) in
            
            //Show the no Content label if the image faild to load.
            response.result.ifFailure {
                self.contentImageView.addSubview(self.noContentLabel)
                self.noContentLabel.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(self.contentImageView)
                    make.centerY.equalTo(self.contentImageView)
                })
            }
        })
    }
}
