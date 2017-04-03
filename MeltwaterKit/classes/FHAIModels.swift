//
//  BooleanQuery.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/2/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import Foundation
import ObjectMapper

struct BooleanQuery {
    var query: String = ""
    var type: String = "article"
    var language: String = "en"
    var startDate: Int = 0
    var endDate: Int = 0
    var country: String = "us"
    var from: Int = 0
    var size: Int = 5
    
}

extension BooleanQuery: Mappable {
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
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

struct DocumentsPage {
    var count: Int = 0
    var documents: [Document] = []
    
}

extension DocumentsPage: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        count    <- map["count"]
        documents <- map["documents"]
    }
}

struct Document {
    var id: String = ""
    var sourceName: String = ""
    var title: String = ""
    var publishDate: Double = 0
    var openingText: String = ""
    var url: String = ""
    var reach: Int = 0
    var indexingTime: Int = 0
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
            let indexingTime = json["indexingTime"] as? Int,
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
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
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

