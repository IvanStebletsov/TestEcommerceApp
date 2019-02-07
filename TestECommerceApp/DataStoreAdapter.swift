//
//  DataStoreAdapter.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 06/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit
import CoreData

protocol SaveData: AnyObject {
    func save()
    func saveNew(name: String, price: String, stock: String)
    func remove(_ item: Item)
    func loadItemsForBackEndAnd(reload tableView: UITableView?) -> [Item]
    func loadItemsForStoreAnd(reload collectionView: UICollectionView?) -> [Item]
}

class DataStoreAdapter: SaveData {
    
    // MARK: - Properties
    var coreDataManager: CoreDataManager?
    
    // MARK: - DataStoreAdapterDelegate methods
    func save() {
        guard let coreDataManager = coreDataManager else { return }
        coreDataManager.saveChanges()
    }
    
    func saveNew(name: String, price: String, stock: String) {
        guard let coreDataManager = coreDataManager else { return }
        let newItem = Item(context: coreDataManager.mainManagedObjectContext)
        newItem.name = name
        newItem.price = price
        newItem.stock = stock
        coreDataManager.saveChanges()
    }
    
    func remove(_ item: Item) {
        guard let coreDataManager = coreDataManager else { return }
        coreDataManager.mainManagedObjectContext.delete(item)
        coreDataManager.saveChanges()
    }
    
    func loadItemsForBackEndAnd(reload tableView: UITableView?) -> [Item] {
        var itemsInStock: [Item] = []
        guard let coreDataManager = coreDataManager else { return [] }
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            itemsInStock = try coreDataManager.mainManagedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("ERROR: \(error): \(error.userInfo)")
        }
        
        guard let tableView = tableView else { return itemsInStock }
        DispatchQueue.main.async {
            tableView.reloadData()
        }
        return itemsInStock
    }
    
    func loadItemsForStoreAnd(reload collectionView: UICollectionView?) -> [Item] {
        var itemsInStore: [Item] = []
        guard let coreDataManager = coreDataManager else { return [] }
        
        let fetchReques: NSFetchRequest<Item> = Item.fetchRequest()
        fetchReques.predicate = NSPredicate(format: "%K != %@", #keyPath(Item.stock), "0")
        
        do {
            itemsInStore = try coreDataManager.mainManagedObjectContext.fetch(fetchReques)
        } catch let error as NSError {
            print("ERROR: \(error): \(error.userInfo)")
        }
        
        guard let collectionView = collectionView else { return itemsInStore }
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
        return itemsInStore
    }
    
}
