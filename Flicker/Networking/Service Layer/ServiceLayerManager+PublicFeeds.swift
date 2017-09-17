//
//  ServiceLayerManager+PublicFeeds.swift
//  Flicker
//
//  Created by Shubham Choudhary on 17/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import ObjectMapper

extension ServiceLayerManager {
    
    // Get pubic feed from Flicker
    class func getPublicFeeds(completionHandler: @escaping (_ feed: FeedJSON?, _ error: String?) -> ()) {
        request(PUBLIC_FEEDS) { (resultValue, errorString) in
            if var resultValue = resultValue {
                // Handle Json parse error for string "\\'"
                if resultValue.contains("\\'") {
                    resultValue = resultValue.replacingOccurrences(of: "\\'", with: "'")
                }
                let feed = Mapper<FeedJSON>().map(JSONString: resultValue)
                completionHandler(feed, nil)
            }else {
                completionHandler(nil, errorString)
            }
        }
    }
}
