//
//  API.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/8/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import Foundation
import Alamofire

public class Network {
    
    public static let baseURL: String = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master"

    //MARK: Endpoints
    
    //Add more endpoint if need.
    public enum Endpoints {
        
        case Challenge
        
        public var method: Alamofire.HTTPMethod {
            switch self {
            case .Challenge:
                return HTTPMethod.get
            }
        }
        
        public var path: String {
            switch self {
            case .Challenge:
                return baseURL+"/challenge.json"
            }
            
        }
        
        //TODO: Create parameters/headers if needed for other endpoints.
    }
    
    public static func request<T:Decodable>(endpoint: Endpoints , completionHandler: @escaping (T?) -> Void)  {
        Alamofire.request(endpoint.path, method: endpoint.method, parameters: nil, encoding: JSONEncoding.default, headers: nil).decodable(success: { (data:T?)  in
            completionHandler(data)
        }) { (error) in
            completionHandler(nil)
        }
    }
}
