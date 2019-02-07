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
    var indexPathOfCurrentItem: IndexPath!
    var itemsInStore: [Item] = []
    var dataStoreAdapter: SaveData?
    
    // MARK: - UI elements
    var swipeCollectionView: UICollectionView!
    var emptyStoreLabel: UIView!
    
    // MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        makeSwipeCollectionView()
        makeEmptyStoreLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Pass an CoreDataStack instance to the BackEndViewController
        guard let adapter = dataStoreAdapter else { return }
        guard let backEndVC = tabBarController?.viewControllers?[1].children.first as? BackEndViewController else { return }
        backEndVC.dataStoreAdapter = adapter
        
        // Load data from CoreData
        itemsInStore = adapter.loadItemsForStoreAnd(reload: swipeCollectionView)
        emptyStoreLabel.isHidden = itemsInStore.count > 0 ? true : false
    }
    
}

