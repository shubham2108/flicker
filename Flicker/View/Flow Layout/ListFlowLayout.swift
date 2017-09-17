//
//  ListFlowLayout.swift
//  Flicker
//
//  Created by Shubham Choudhary on 16/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit

class ListFlowLayout: UICollectionViewFlowLayout {
    
    var selctedIndex: IndexPath?
    
    // Class initialization
    override init() {
        super.init()
        setupLayout()
    }
    
    init(index: IndexPath?) {
        super.init()
        selctedIndex = index
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    // Set up the layout for the collection view
    fileprivate func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
    }
    
    // Set cell width
    func itemWidth() -> CGFloat {
        if let collectionView = collectionView {
            return collectionView.frame.width
        }else {
            return 375.0
        }
    }
    
    // Set cell height
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
        // Return the CollectionView content offset if selected index is nil
        guard let collectionView = collectionView else { return .zero }
        
        if let index = selctedIndex {
            // Return the selected index offset
            return CGPoint(x: itemWidth() * CGFloat(index.item) , y: collectionView.contentOffset.y)
        }else {
            return collectionView.contentOffset
        }
    }
    
    // Handle pagination effect in the CollectionView
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView, let attributesForVisibleCells = layoutAttributesForElements(in: collectionView.bounds) else {
            // Fallback
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        
        let halfWidth = collectionView.bounds.size.width / 2
        let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
        
        var candidateAttributes : UICollectionViewLayoutAttributes?
        for attributes in attributesForVisibleCells {
            // Skip if the layout attributes are not intended to a cell
            if attributes.representedElementCategory != .cell {
                continue
            }
            if let candAttrs = candidateAttributes {
                let right = attributes.center.x - proposedContentOffsetCenterX
                let left = candAttrs.center.x - proposedContentOffsetCenterX
                if fabsf(Float(right)) < fabsf(Float(left)) {
                    candidateAttributes = attributes
                }
            }else {
                // Initialize the layout attributes for the first time
                candidateAttributes = attributes
            }
        }
        guard let attributes = candidateAttributes else { return .zero }
        return CGPoint(x : attributes.center.x - halfWidth, y : proposedContentOffset.y)
    }
}
