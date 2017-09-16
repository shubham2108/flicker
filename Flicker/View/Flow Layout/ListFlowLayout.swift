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
    
    // Class initilazation methods
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
    
    //Sets up the layout for the collectionView. 0 distance between each cell, and horizontal layout
    fileprivate func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
    }
    
    // Set cell width here
    func itemWidth() -> CGFloat {
        return collectionView!.frame.width
    }
    
    // Set cell height here
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
        //return collection view content offset if selected index is nil
        guard let index = selctedIndex else {
            return collectionView!.contentOffset
        }
        //return selected index offset
        return CGPoint(x: itemWidth() * CGFloat(index.item) , y: collectionView!.contentOffset.y)
    }
    
    // Handling pagination effect in collection view
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView, let attributesForVisibleCells = layoutAttributesForElements(in: collectionView.bounds) else {
            // Fallback
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        
        let halfWidth = collectionView.bounds.size.width / 2
        let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
        
        var candidateAttributes : UICollectionViewLayoutAttributes?
        for attributes in attributesForVisibleCells {
            //Skip if layout attributes are not intended for a cell
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
                // Initialize for first time
                candidateAttributes = attributes
            }
        }
        return CGPoint(x : candidateAttributes!.center.x - halfWidth, y : proposedContentOffset.y)
    }
}
