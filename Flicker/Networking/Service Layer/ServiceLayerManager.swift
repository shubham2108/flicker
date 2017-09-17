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
    
    // function to handles the API response for any error and returns the result value
    class func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, completionHandler: @escaping (_ responseData: Any?, _ error: String?) -> ()) {
        
        if Reachability()?.currentReachabilityStatus != .notReachable {
            Alamofire.request(url).responseJSON { responseData in
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


