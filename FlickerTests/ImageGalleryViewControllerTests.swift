//
//  ImageGalleryViewControllerTests.swift
//  Flicker
//
//  Created by Shubham Choudhary on 14/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import XCTest
@testable import Flicker

class ImageGalleryViewControllerTests: XCTestCase {
    
    var galleryViewController: ImageGalleryViewController!
    
    var expectation: XCTestExpectation?
    let expectationTimeout = 60
    
    override func setUp() {
        super.setUp()
        loadViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func loadViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController: ImageGalleryViewController = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as? ImageGalleryViewController {
            galleryViewController = viewController
            _ = galleryViewController.view
            getPublicFeeds()
            galleryViewController.viewWillAppear(true)
        }
    }
    
    // Test that view controller confirms to CollectionView data source
    func testConfirmsToCollectionViewDataSource() {
        if let viewController = galleryViewController {
            XCTAssertTrue(viewController.conforms(to: UICollectionViewDataSource.self))
        }
    }
    
    // Test that view controller confirms to CollectionView delegate
    func testConfirmsToCollectionViewDelegate() {
        if let viewController = galleryViewController {
            XCTAssertTrue(viewController.conforms(to: UICollectionViewDelegate.self))
        }
    }
        
    // Test number of collection view cell against to feed items
    func testNumberOfCells() {
        if let collectionView = galleryViewController.imageCollectionView, let feedItems = galleryViewController.publicFeed?.items?.count {
            let noOfCells = collectionView.numberOfItems(inSection: 0)
            XCTAssertEqual(feedItems, noOfCells)
        }
    }
    
    func testCollectionViewCellConfigureMethod() {
        if let collectionView = galleryViewController.imageCollectionView, let feedItems = galleryViewController.publicFeed?.items?.count {
            for item in 0 ..< feedItems {
                let indexPath = IndexPath(row: item, section: 0)
                _ = galleryViewController.collectionView(collectionView, cellForItemAt: indexPath)
            }
        }
    }
    
    func testCollectionViewLayout() {
        if let collectionView = galleryViewController.imageCollectionView {
            galleryViewController.isGrid = true
            galleryViewController.manageCollectionViewLayout(collectionView, indexPath: nil)
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

extension ImageGalleryViewControllerTests {
    
    // MARK: - Public feeds API call
    
    func getPublicFeeds() {
        self.expectation = self.expectation(description: "Expectation for public feeds")
        ServiceLayerManager.getPublicFeeds { [weak self] (feed, error) in
            guard let strongSelf = self else { return }
            if let feed = feed {
                strongSelf.galleryViewController.publicFeed = feed
                strongSelf.expectation?.fulfill()
            }else {
                XCTAssertNil(error, "\(String(describing: error))")
            }
        }
        waitForExpectations(timeout: TimeInterval(self.expectationTimeout)) { (error) in
            XCTAssertNil(error, "\(String(describing: error))")
        }
    }
}
