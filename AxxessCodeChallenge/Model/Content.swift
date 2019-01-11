//
//  Challenge.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/8/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import Foundation

public struct Content: Codable {
    let id: String
    let type: ContentType
    let data: String?
    var date: Date?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(ContentType.self, forKey: .type)
        data = try container.decodeIfPresent(String.self, forKey: .data)
        //Convert formated date string into date type. 
        let dateString: String? = try container.decodeIfPresent(String.self, forKey: .date)
        if let dateString = dateString {
            date = Date.stringToDate(dateString: dateString)
        } else {
            date = nil
        }
    }
}
