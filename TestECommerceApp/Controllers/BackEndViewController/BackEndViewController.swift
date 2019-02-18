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
    var dataStorage: DataStorage?
    
    // MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeStockTableView()
        makeEmptyStoreLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        // Load data from CoreData
        guard let dataStorage = dataStorage else { return }
        
        itemsInStock = dataStorage.loadItemsForBackEnd()
        
        DispatchQueue.main.async { [unowned self] in
            self.stockTableView.reloadData()
        }
        
        navigationItem.title = "Колличесвто позиций: \(itemsInStock.count)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
    }
    
    override func viewWillLayoutSubviews() {
        setupBackgroundImage()
    }

}
