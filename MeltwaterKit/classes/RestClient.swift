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

class RestClient {
    
    static let headers: HTTPHeaders = [
        "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRoaW5oLm5ndXllbkBtZWx0d2F0ZXIuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOi8vZmhhaS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTU3MDgwNjk4NjA1MTcwNTU2NjIiLCJhdWQiOiJQTk9aV3AyNXc1VUNQNjNDd3MwRkprbTFiU090NGRiUCIsImV4cCI6MTQ5MTIwODUyOSwiaWF0IjoxNDkxMTcyNTI5fQ.LxwbnL9ITqbzcoU5BpZ0R-3HKBi8V0T18itNvBjerB4",
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
    
    internal static func postToUrl(urlString: String, payload: Parameters? ) -> Promise<DocumentsPage> {
        
        return Promise { fulfill, reject in
            Alamofire.request(urlString, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: headers)
                .validate().responseObject { (response: DataResponse<DocumentsPage>) in
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
