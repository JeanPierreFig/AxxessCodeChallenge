//
//  DetailViewController.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/10/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var data: Content?

    var idlabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Id:"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var noContentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.lightGray
        label.text = NSLocalizedString("Could not load content.", comment: "")
        return label
    }()
    
    lazy var contentImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var contentTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.textColor = UIColor.black
        textView.isEditable = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        //View Setup
        self.view.backgroundColor = UIColor.white
        //Content will show under the navigation bar when using "make.topMargin". The view needs to apply edgesForExtendedLayout with []
        self.edgesForExtendedLayout = []
        
        //Unwrap data
        guard let data = data,
            let contentData = data.data else { return }
        
        self.view.addSubview(idlabel)
        idlabel.text = "Id: \(data.id)"
        idlabel.snp.makeConstraints { (make) in
            make.leadingMargin.equalTo(self.view).offset(5)
            make.topMargin.equalTo(self.view).offset(15)
        }
        
        //If date is avalable add the date label.
        if let date = data.date {
            self.view.addSubview(dateLabel)
            dateLabel.text = Date.dateFormat(date: date)
            dateLabel.snp.makeConstraints { (make) in
                make.trailingMargin.equalTo(self.view).offset(-5)
                make.topMargin.equalTo(self.view).offset(15)
            }
        }
        
        //Depending on the data type show imageview or text view.
        if data.type == .Image {
            self.view.addSubview(contentImageView)
            self.getImageFor(path: contentData)
            contentImageView.snp.makeConstraints { (make) in
                make.height.equalTo(350)
                make.leadingMargin.equalToSuperview()
                make.trailingMargin.equalToSuperview()
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        } else {
            self.view.addSubview(contentTextView)
            //Set text data
            self.contentTextView.text = contentData
            contentTextView.snp.makeConstraints { (make) in
                make.top.equalTo(idlabel.snp_bottomMargin).offset(10)
                make.bottomMargin.equalToSuperview()
                make.leadingMargin.equalToSuperview()
                make.trailingMargin.equalToSuperview()
            }
        }
    }
    
    private func getImageFor(path: String) {
        guard let url =  URL(string: path) else { return }
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
