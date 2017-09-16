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
    let reuseIdentifier = "feedCell"
    let cellNibName = "FeedImageCell"
    
    
    //Type Properties
    var publicFeed : FeedJSON? = nil
    var isGrid = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFeeds()
    }
    
    //Here initialize view controller
    func initializeViewController() {
        registerCollectionViewCell()
        imageCollectionView.setCollectionViewLayout(GridFlowLayout(), animated: true)
    }
    
    // Register custom cell with collection view
    fileprivate func registerCollectionViewCell() {
        let cellNib = UINib(nibName: cellNibName, bundle:nil)
        imageCollectionView.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    //Refresh Flicker gallery with new public images
    @IBAction func refreshGallery(_ sender: UIBarButtonItem) {
        getFeeds()
    }
    
    //Manage UICollection View Layout
    func manageCollectionViewLayout(_ collectionView: UICollectionView, indexPath: IndexPath?) {
        UIView.animate(withDuration: 0.2) { () -> Void in
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.setCollectionViewLayout(self.isGrid ? ListFlowLayout(index: indexPath) : GridFlowLayout(), animated: true)
        }
        isGrid = !isGrid
        // change background color based on flow layout
        collectionView.backgroundColor = isGrid ? .clear : .black
    }
    
    // Get public feed from flicker
    fileprivate func getFeeds() {
        ServiceLayerManager.getPublicFeeds { [weak self] (feed, error) in
            if let feed = feed {
                self?.publicFeed = feed
                self?.imageCollectionView.reloadData()
            }else {
                guard let error = error else {return}
                self?.showAlert(title: ERROR, message: error, completionHandler: { [weak self] action in
                    self?.handleAlertActions(actoin: action)
                })
            }
        }
    }
    
    //Handle alert actions
    func handleAlertActions(actoin: UIAlertAction) {
        switch actoin.style {
        case .default:
            getFeeds()
        default:
            navigationController?.popViewController(animated: true)
        }
    }
}



