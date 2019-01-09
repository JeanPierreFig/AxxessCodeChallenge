//
//  ViewController.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/8/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      let _ = Network.request(endpoint: .Challenge) { (content: [Content]?) in
            if let content = content {
                print(content)
            }
        }
    }

}

