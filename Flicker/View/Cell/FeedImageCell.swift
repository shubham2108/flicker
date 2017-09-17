//
//  FeedImageCell.swift
//  Flicker
//
//  Created by Shubham Choudhary on 14/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit
import SDWebImage

class FeedImageCell: UICollectionViewCell {
    
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    var imageURL: String? {
        didSet {
            // Download image from image URL
            if let url = imageURL {
                feedImageView.sd_setShowActivityIndicatorView(true)
                feedImageView.sd_setIndicatorStyle(.gray)
                feedImageView.sd_setImage(with:  URL(string: url), placeholderImage: #imageLiteral(resourceName: "placeholder"), options: .progressiveDownload, completed: nil)
            }
        }
    }
    // Reset cell content for reusability
    override func prepareForReuse() {
        super.prepareForReuse()
        feedImageView.image = nil
    }

}
