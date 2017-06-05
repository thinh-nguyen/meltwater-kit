//
//  BooleanQuery.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/2/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import Foundation
import ObjectMapper

public struct BooleanQuery {
    var query: String = ""
    var type: String = "article"
    var language: String = "en"
    var startDate: Double = 0
    var endDate: Double = 0
    var country: String = "us"
    var from: Int = 0
    var size: Int = 5
    
}

extension BooleanQuery: Mappable {
    
    public init?(map: Map) {
        mapping(map: map)
    }
    
    mutating public func mapping(map: Map) {
        query       <- map["query"]
        type        <- map["type"]
        language    <- map["language"]
        startDate   <- map["startDate"]
        endDate     <- map["endDate"]
        country     <- map["country"]
        from        <- map["from"]
        size        <- map["size"]
    }
    
    
    
}

public struct DocumentsPage {
    var count: Int = 0
    var documents: [Document] = []
    
}

public struct SocialEcho {
    var facebook: Int = 0
    var twitter: Int = 0
    var linkedin: Int = 0
    
}
extension SocialEcho: Mappable {
   
    public init?(map: Map) {
        
    }
    
    mutating public func mapping(map: Map) {
    }
}

extension DocumentsPage: Mappable {
    
    public init?(map: Map) {
        
    }
    
    mutating public func mapping(map: Map) {
        count    <- map["count"]
        documents <- map["documents"]
    }
}

public struct Document {
    var id: String = ""
    var sourceName: String = ""
    var title: String = ""
    var publishDate: Double = 0
    var openingText: String = ""
    var url: String = ""
    var reach: Int = 0
    var indexingTime: Double = 0
    var sentimentDiscrete: String = ""
    var imageUrl: String = ""
    
    public init?(json: [String: Any]) {
        guard
            let id = json["id"] as? String,
            let sourceName = json["sourceName"] as? String,
            let title = json["title"] as? String,
            let publishDate = json["body"] as? Double,
            let openingText = json["openingText"] as? String,
            let url = json["url"] as? String,
            let reach = json["reach"] as? Int,
            let indexingTime = json["indexingTime"] as? Double,
            let imageUrl = json["imageUrl"] as? String,
            let sentimentDiscrete = json["sentimentDiscrete"] as? String
            else { return nil }
        
        self.id = id
        self.publishDate = publishDate
        self.title = title
        self.sourceName = sourceName
        self.openingText = openingText
        self.url = url
        self.reach = reach
        self.indexingTime = indexingTime
        self.sentimentDiscrete = sentimentDiscrete
        self.imageUrl = imageUrl
        
    }
    
}

extension Document: Mappable {
    
    public init?(map: Map) {
        
    }
    
    mutating public func mapping(map: Map) {
        id                <- map["id"]
        publishDate       <- map["publishDate"]
        title             <- map["title"]
        sourceName        <- map["sourceName"]
        openingText       <- map["openingText"]
        url               <- map["url"]
        reach             <- map["reach"]
        indexingTime      <- map["indexingTime"]
        imageUrl          <- map["imageUrl"]
        sentimentDiscrete <- map["sentimentDiscrete"]
    }
}


//curl -X GET -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRoaW5oLm5ndXllbkBtZWx0d2F0ZXIuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOi8vZmhhaS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTU3MDgwNjk4NjA1MTcwNTU2NjIiLCJhdWQiOiJQTk9aV3AyNXc1VUNQNjNDd3MwRkprbTFiU090NGRiUCIsImV4cCI6MTQ5MTY0OTE2NSwiaWF0IjoxNDkxNjEzMTY1fQ.C_LdDIGvf6bza4NtT16l_oOqLvWKIGT64ipq5Mrd2oA" https://api-sbox.fairhair.ai/insights/v1/b63054db6ca1240e8484a8d4cbbb44f4/workflows/3177bd92-a426-418e-b3bd-5997b1647549/jobs/api_b63054db6ca1240e8484a8d4cbbb44f4/results/35a87401-c6f1-4f7b-a46e-606faeeca877

//{"metadata":
//    {"messageID":"787e4d1d-0bc9-48c1-9cbd-216371d6c6b9","docId":"35a87401-c6f1-4f7b-a46e-606faeeca877","source":"api"},
//    "enrichments":{
//        "fhaiSocialEcho":{
//            "facebook":{
//                "error":"FbErrorDTO{error=Error{message='(#803) Some of the aliases you requested do not exist: demo text', fbTraceId='CVa+ApJfEP/', code='803', type='OAuthException'}}"},
//            "linkedin":{"error":"LinkedIn API returned code 400, with body [Invalid URL parameter: demo text\r\n]"},
//            "twitter":{"shares":100},
//            "url":"demo text"
//        }
//    }
//}
