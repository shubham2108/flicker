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
            self.getFeeds()
        default:
            self.navigationController?.popViewController(animated: true)
        }
    }
}



