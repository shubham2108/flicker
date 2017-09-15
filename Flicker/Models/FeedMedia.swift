//
//  FeedMedia.swift
//  Flicker
//
//  Created by Shubham Choudhary on 14/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedMedia: Mappable {
    
    var m: String?
    
    required init?(map: Map){}
    
    init() {}
    
    func mapping(map: Map) {
        self.m <- map["m"]
    }
    
    
}
