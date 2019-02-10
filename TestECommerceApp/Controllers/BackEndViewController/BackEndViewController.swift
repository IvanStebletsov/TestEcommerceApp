//
//  BackEndViewController.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 04/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit
import CoreData

class BackEndViewController: UIViewController {

    // MARK: - Properties
    let cellId = "Cell"
    
    // MARK: - UI elements
    var stockTableView: UITableView!
    var emptyStoreLabel: UIView!
    var itemsInStock: [Item] = []
    var dataStoreAdapter: SaveData?
    
    // MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeStockTableView()
        makeEmptyStoreLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        // Load data from CoreData
        guard let adapter = dataStoreAdapter else { return }
        itemsInStock = adapter.loadItemsForBackEndAnd(reload: stockTableView)
        
        navigationItem.title = "Колличесвто позиций: \(itemsInStock.count)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
    }
    
    override func viewWillLayoutSubviews() {
        setupBackgroundImage()
    }

}
