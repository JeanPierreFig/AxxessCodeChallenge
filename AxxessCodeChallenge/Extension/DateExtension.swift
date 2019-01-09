//
//  DateExtension.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/9/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import Foundation

extension Date {
    
   public static func stringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        let dateFormat = "dd/MM/yyyy"
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: dateString) ?? nil
    }
}
