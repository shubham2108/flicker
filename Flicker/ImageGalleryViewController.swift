//
//  ImageGalleryViewController.swift
//  Flicker
//
//  Created by Shubham Choudhary on 14/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    // Static Properties
    fileprivate let reuseIdentifier = "feedCell"
    fileprivate let cellNibName = "FeedImageCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    fileprivate let cellSize = CGSize(width: 100.0, height: 100.0)
    
    //Type Properties
    var publicFeed : FeedJSON? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFeeds()
    }
    
    // Get public feed from flicker
    fileprivate func getFeeds() {
        ServiceLayerManager.getPublicFeeds { [weak self] (feed, error) in
            if let feed = feed {
                self?.publicFeed = feed
                self?.imageCollectionView.reloadData()
            }else {
                guard let error = error else {return}
                self?.showAlert(title: ERROR, message: error, completionHandler: { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    // Register custom cell with collection view
    fileprivate func registerCollectionViewCell() {
        let cellNib = UINib(nibName: cellNibName, bundle:nil)
        imageCollectionView.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}

// MARK: - CollectionView Delegate and DataSource

extension ImageGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return publicFeed?.items?.count ?? 0
    }
    
    // Make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get a reference to our storyboard cell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as? FeedImageCell {
            cell.imageURL = publicFeed?.items?[indexPath.row].media?.m
            return cell
        }
        return UICollectionViewCell()
    }
    
}

// MARK: - CollectionView FlowLayout Delegate

extension ImageGalleryViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
