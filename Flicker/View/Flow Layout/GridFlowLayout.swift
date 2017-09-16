//
//  GridFlowLayout.swift
//  Flicker
//
//  Created by Shubham Choudhary on 16/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {

    // here you can define the sectionInset of collection view
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    //here you can define the number of columns in grid view
    let numberOfColumns: CGFloat = 3
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    
    //Sets up the layout for the collectionView with a vertical layout
    
    func setupLayout() {
        scrollDirection = .vertical
        sectionInset = sectionInsets
    }
    
    /// here we define the width of each cell,
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.width - (sectionInsets.left * (numberOfColumns+1)))/numberOfColumns
    }
    
    func itemHeight() -> CGFloat {
        return itemWidth()
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight())
        }
        get {
            return CGSize(width: itemWidth(), height: itemHeight())
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
    
}
