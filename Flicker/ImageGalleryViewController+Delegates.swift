//
//  ImageGalleryViewController+Delegates.swift
//  Flicker
//
//  Created by Shubham Choudhary on 16/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit

// MARK: - CollectionView Delegate and DataSource

extension ImageGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryViewModel.numberOfItems(in: section)
    }
    
    // Make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get a reference to our storyboard cell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as? FeedImageCell {
            cell.imageURL = galleryViewModel?.imageUrl(for: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    //zoom the selected image
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        manageCollectionViewLayout(collectionView, indexPath: indexPath)
    }
    
}
