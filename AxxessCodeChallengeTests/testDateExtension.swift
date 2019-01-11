//
//  testDateExtension.swift
//  AxxessCodeChallengeTests
//
//  Created by Jean Pierre on 1/11/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import XCTest
@testable import AxxessCodeChallenge

class testDateExtension: XCTestCase {
    
    func testDateFormater() {
     
        let dateString = "01/10/2019"
        let date = Date.stringToDate(dateString: dateString)
        XCTAssertNotNil(date)
        
        let dateStringFormated = Date.dateFormat(date: date ?? Date())
        XCTAssertEqual(dateString, dateStringFormated)
    }


}
