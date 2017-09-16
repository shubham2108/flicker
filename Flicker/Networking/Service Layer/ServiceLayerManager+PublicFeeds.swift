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
    
    // function to get pubic feed from Flicker
    class func getPublicFeeds(completionHandler: @escaping (_ feed: FeedJSON?, _ error: String?) -> ()) {
        request(PUBLIC_FEEDS) { (resultValue, errorString) in
            if let resultValue = resultValue {
                let feed = Mapper<FeedJSON>().map(JSONObject: resultValue)
                completionHandler(feed, nil)
            }else {
                completionHandler(nil, errorString)
            }
        }
    }
}
