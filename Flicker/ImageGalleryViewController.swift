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
    @IBOutlet var galleryViewModel: ImageGalleryViewModel!
    
    // MARK: - Properties
    
    // Constant Properties
    let reuseIdentifier = "feedCell"
    let cellNibName = "FeedImageCell"
    
    // Variable Properties
    var isGrid = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFeeds()
    }
    
    // Initialize the view of the controller
    func initializeViewController() {
        registerCollectionViewCell()
        imageCollectionView.setCollectionViewLayout(GridFlowLayout(), animated: true)
    }
    
    // Register custom cell with CollectionView
    fileprivate func registerCollectionViewCell() {
        let cellNib = UINib(nibName: cellNibName, bundle:nil)
        imageCollectionView.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    //Refresh Flicker gallery with new public images
    @IBAction func refreshGallery(_ sender: UIBarButtonItem) {
        getFeeds()
    }
    
    //Manage CollectionView Layout
    func manageCollectionViewLayout(_ collectionView: UICollectionView, indexPath: IndexPath?) {
        UIView.animate(withDuration: 0.2) { () -> Void in
            collectionView.setCollectionViewLayout(self.isGrid ? ListFlowLayout(index: indexPath) : GridFlowLayout(), animated: true)
        }
        isGrid = !isGrid
        // Change background color based on flow layout
        collectionView.backgroundColor = isGrid ? .clear : .black
    }
    
    // Get public feed from Flicker
    fileprivate func getFeeds() {
        galleryViewModel?.getFeeds(completion: { [weak self] (success, error) in
            guard let strongSelf = self else { return }
            if success {
                strongSelf.imageCollectionView.reloadData()
            }else {
                guard let error = error else {return}
                strongSelf.showAlert(title: ERROR, message: error, completionHandler: { action in
                    strongSelf.handleAlertActions(actoin: action)
                })
            }
        })
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



