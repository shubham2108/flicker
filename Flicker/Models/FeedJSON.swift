//
//  FeedJSON.swift
//  Flicker
//
//  Created by Shubham Choudhary on 14/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedJSON: Mappable {
    
    var title: String?
    var link: String?
    var description: String?
    var modified: String?
    var generator: String?
    var items: [FeedItem]?
    
    required init?(map: Map){}
    
    init() {}
    
    func mapping(map: Map) {
        self.title <- map["title"]
        self.link <- map["link"]
        self.description <- map["description"]
        self.modified <- map["modified"]
        self.generator <- map["generator"]
        self.items <- map["items"]
    }
    
}
