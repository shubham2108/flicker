//
//  FeedItem.swift
//  Flicker
//
//  Created by Shubham Choudhary on 14/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedItem: Mappable {
    
    
    var title: String?
    var link: String?
    var media: FeedMedia?
    var date_taken: String?
    var description: String?
    var published: String?
    var author: String?
    var author_id: String?
    var tags: String?
    
    required init?(map: Map){}
        
    func mapping(map: Map) {
        self.title <- map["title"]
        self.link <- map["link"]
        self.media <- map["media"]
        self.date_taken <- map["date_taken"]
        self.description <- map["description"]
        self.published <- map["published"]
        self.author <- map["author"]
        self.author_id <- map["author_id"]
        self.tags <- map["tags"]
    }
    
}
