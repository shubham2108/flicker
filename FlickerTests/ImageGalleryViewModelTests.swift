//
//  ImageGalleryViewModelTests.swift
//  Flicker
//
//  Created by Shubham Choudhary on 17/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import XCTest
@testable import Flicker

class ImageGalleryViewModelTests: XCTestCase {
    
    var galleryViewModel: ImageGalleryViewModel!
    
    var expectation: XCTestExpectation?
    let expectationTimeout = 60
    
    override func setUp() {
        super.setUp()
        galleryViewModel = ImageGalleryViewModel()
        getPublicFeeds()
    }
    
    // Test ViewModel for number Of Items
    func testNumberOfItems() {
        if let feeds = galleryViewModel.publicFeed {
            let feedItems = feeds.items?.count
            let noOfItems = galleryViewModel.numberOfItems(in: 0)
            XCTAssertEqual(feedItems, noOfItems)
        }
    }
    
    // Test ViewModel for image URL
    func testImageUrl() {
        if let feedItems = galleryViewModel.publicFeed?.items {
            for (index, item) in feedItems.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                let imageURL = galleryViewModel.imageUrl(for: indexPath)
                if let url = item.media?.m {
                    XCTAssertEqual(imageURL, url)
                }
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

extension ImageGalleryViewModelTests {
    
    // MARK: - Public feeds API call
    
    func getPublicFeeds() {
        self.expectation = self.expectation(description: "Expectation for public feeds")
        ServiceLayerManager.getPublicFeeds { [weak self] (feed, error) in
            guard let strongSelf = self else { return }
            if let feed = feed {
                strongSelf.galleryViewModel.publicFeed = feed
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
