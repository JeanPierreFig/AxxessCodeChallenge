//
//  AlamofireExtension.swift
//  AxxessCodeChallenge
//
//  Created by Jean Pierre on 1/8/19.
//  Copyright © 2019 Jean Pierre. All rights reserved.
//

import Foundation
import Alamofire

//https://gist.github.com/hirohisa/76627c0c4fffa5dce878b9633acadf36
extension Alamofire.DataRequest {
    @discardableResult
    func decodable<T: Decodable>(success: @escaping (T) -> Void, failure: @escaping (Error?) -> Void) -> Self {
        response(completionHandler: { response in
            if let error = response.error {
                failure(error)
                return
            }
            if let data = response.data {
                guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                    failure(nil)
                    return
                }
                success(result)
            }
        })
        return self
    }
}
