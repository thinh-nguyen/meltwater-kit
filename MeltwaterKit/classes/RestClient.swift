//  RestClient.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/1/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

public class RestClient {
    
    public static let headers: HTTPHeaders = [
        "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRoaW5oLm5ndXllbkBtZWx0d2F0ZXIuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOi8vZmhhaS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTU3MDgwNjk4NjA1MTcwNTU2NjIiLCJhdWQiOiJQTk9aV3AyNXc1VUNQNjNDd3MwRkprbTFiU090NGRiUCIsImV4cCI6MTQ5MTY0OTE2NSwiaWF0IjoxNDkxNjEzMTY1fQ.C_LdDIGvf6bza4NtT16l_oOqLvWKIGT64ipq5Mrd2oA",
        "Accept": "application/json"
    ]
    
    internal static func getFromUrl(urlString: String) -> Promise<NSDictionary> {
        
        return Promise { fulfill, reject in
            Alamofire.request(urlString).validate().responseJSON { response in
                    switch response.result {
                        case .success(let dict):
                            fulfill(dict as! NSDictionary)
                        case .failure(let error):
                                reject(error)
                }
            }
        }
    }
    
    internal static func getFromUrl(urlString: String, parameters: Parameters? ) -> Promise<NSDictionary> {
        
        return Promise { fulfill, reject in
            Alamofire.request(urlString, parameters: parameters).validate().responseJSON { response in
                switch response.result {
                case .success(let dict):
                    fulfill(dict as! NSDictionary)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
    
    internal static func postToUrl<T: Mappable>(urlString: String, payload: Parameters? ) -> Promise<T> {
        return Promise { fulfill, reject in
            Alamofire.request(urlString, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: headers)
                .validate().responseObject { (response: DataResponse<T>) in
                    switch response.result {
                    case .success(let obj):
                        fulfill(obj )
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
    }
    
}

