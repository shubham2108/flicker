//
//  ServiceLayerManager.swift
//  Flicker
//
//  Created by Shubham Choudhary on 14/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ServiceLayerManager {
    
    enum FeedAPI: String {
        case baseURL = "https://api.flickr.com/"
        case publicURL = "services/feeds/photos_public.gne?lang=en-us&format=json&nojsoncallback=1"
    }
        
    class func getPublicFeeds(completionHandler: @escaping (_ feed: FeedJSON?, _ error: String?) -> ()) {
        if Reachability()?.currentReachabilityStatus != .notReachable {
            let publicFeedURL = FeedAPI.baseURL.rawValue + FeedAPI.publicURL.rawValue
            
            Alamofire.request(publicFeedURL).responseJSON { responseData in
                if let resultValue = responseData.result.value {
                    let feed = Mapper<FeedJSON>().map(JSONObject: resultValue)
                    completionHandler(feed, nil)
                }else {
                    completionHandler(nil, responseData.error.debugDescription)
                }
            }
        }else {
            completionHandler(nil, NO_CONNECTION)
        }
    }    
}
