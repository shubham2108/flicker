//
//  ImageGalleryViewModel.swift
//  Flicker
//
//  Created by Shubham Choudhary on 17/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit

class ImageGalleryViewModel: NSObject {

    //Type Properties
    var publicFeed : FeedJSON? = nil
    
    // Get public feed from flicker
    func getFeeds(completion: @escaping (_ success: Bool, _ error: String?) -> ()) {
        ServiceLayerManager.getPublicFeeds { [weak self] (feed, error) in
            guard let strongSelf = self else { return }
            if let feed = feed {
                strongSelf.publicFeed = feed
                completion(true, nil)
            }else {
                guard let error = error else {return}
                completion(false, error)
            }
        }
    }
    
    // MARK: - Values to display in collection view
    func numberOfItems(in section: Int) -> Int {
        return publicFeed?.items?.count ?? 0
    }
    
    func imageUrl(for indexPath: IndexPath) -> String? {
        return publicFeed?.items?[indexPath.row].media?.m
    }
    
}
