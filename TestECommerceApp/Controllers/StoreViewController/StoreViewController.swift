//
//  StoreViewController.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 06/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit
import CoreData

class StoreViewController: UIViewController {
    
    // MARK: - Properties
    let cellId = "Cell"
    var indexPath = IndexPath(item: 0, section: 0)
    var itemsInStore: [Item] = []
    var dataStorage: DataStorage?
    
    // MARK: - UI elements
    var swipeCollectionView: UICollectionView!
    var emptyStoreLabel: UIView!
    
    // MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeSwipeCollectionView()
        makeEmptyStoreLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Pass an CoreDataStack instance to the BackEndViewController
        guard let dataStorage = dataStorage else { return }
        guard let backEndVC = tabBarController?.viewControllers?[1].children.first as? BackEndViewController else { return }
        backEndVC.dataStorage = dataStorage
        
        // Load data from CoreData
        itemsInStore = dataStorage.loadItemsForStore()
        
        DispatchQueue.main.async { [unowned self] in
            self.swipeCollectionView.reloadData()
        }
        
        emptyStoreLabel.isHidden = itemsInStore.count > 0 ? true : false
        
        guard !itemsInStore.isEmpty, indexPath.row <= itemsInStore.count - 1 else { return }
        DispatchQueue.main.async {
            self.swipeCollectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    override func viewWillLayoutSubviews() {
        setupBackgroundImage()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let numberOfItemCard = targetContentOffset.pointee.x / view.frame.width
        indexPath = IndexPath(item: Int(numberOfItemCard), section: 0)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        swipeCollectionView.collectionViewLayout.invalidateLayout()
        guard !itemsInStore.isEmpty, indexPath.row <= itemsInStore.count - 1 else { return }
        DispatchQueue.main.async {
            self.swipeCollectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

