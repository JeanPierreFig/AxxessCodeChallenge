//
//  DateExtension.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/9/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import Foundation

extension Date {

    /**
     - Parameter dateString: date string in dd/MM/yyyy format
     - Returns: converted string to optional date type.
     
     ### Uses Example: ###
     ````
     if let date = Date.stringToDate(dateString: "9/1/2019") {
        print(date)
     }
     ````
     */
   public static func stringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        let dateFormat = "dd/MM/yyyy"
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: dateString) ?? nil
    }
    
    /**
     - Parameter date: pass in date type
     - Returns: converted string in dd/MM/yyyy format
     
     ### Uses Example: ###
     ````
     if let date = Date.dateFormat(date: Date()) {
        print(date)
     }
     ````
     */
   public static func dateFormat(date: Date) -> String {
        let convertTo = DateFormatter()
        convertTo.dateFormat = "dd/MM/yyyy"
        return convertTo.string(from: date)
    }
}
