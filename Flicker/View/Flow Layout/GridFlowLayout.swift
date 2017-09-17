//
//  GridFlowLayout.swift
//  Flicker
//
//  Created by Shubham Choudhary on 16/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {

    // Define the sectionInset of collection view
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    // Define the number of columns in grid view
    let numberOfColumns: CGFloat = 3
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    
    // Set up the layout for the CollectionView
    
    func setupLayout() {
        scrollDirection = .vertical
        sectionInset = sectionInsets
    }
    
    // Define the width of each cell
    func itemWidth() -> CGFloat {
        if let collectionView = collectionView {
            return (collectionView.frame.width - (sectionInsets.left * (numberOfColumns+1)))/numberOfColumns
        }else {
            return 100.0
        }
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
        if let collectionView = collectionView {
            return collectionView.contentOffset
        }else {
            return .zero
        }
    }
    
}
