//
//  testNetwork.swift
//  AxxessCodeChallengeTests
//
//  Created by Jean Pierre on 1/11/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import XCTest
@testable import AxxessCodeChallenge

class testNetwork: XCTestCase {

    func testNetworkDownlowd() {
        //Check if the json is been converted into arrray of content.
        //Note if you do not have a connecting to the internet it will not pass.
        Network.request(endpoint: .Challenge) { (content: [Content]?) in
            XCTAssertNotNil(content)
        }
    }

}
