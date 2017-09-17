//
//  ServiceLayerManager.swift
//  Flicker
//
//  Created by Shubham Choudhary on 14/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation
import Alamofire
import ReachabilitySwift

class ServiceLayerManager {
    
    // Handle API response
    class func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, completionHandler: @escaping (_ responseData: String?, _ error: String?) -> ()) {
        
        // Check Network Connectivity
        if Reachability()?.currentReachabilityStatus != .notReachable {
            Alamofire.request(url).responseString { responseData in
                if let resultValue = responseData.result.value {
                    completionHandler(resultValue, nil)
                }else {
                    completionHandler(nil, responseData.error?.localizedDescription)
                }
            }
        }else {
            completionHandler(nil, NO_CONNECTION)
        }
    }
}


