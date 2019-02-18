//
//  DataStoreAdapter.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 06/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit
import CoreData

protocol DataStorage: AnyObject {
    func save()
    func saveNew(name: String, price: String, stock: String)
    func remove(_ item: Item)
    func loadItemsForBackEnd() -> [Item]
    func loadItemsForStore() -> [Item]
}

class DataSaver: DataStorage {
    
    // MARK: - Properties
    var coreDataManager: CoreDataStorage?
    
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
    
    func loadItemsForBackEnd() -> [Item] {
        var itemsInStock: [Item] = []
        guard let coreDataManager = coreDataManager else { return [] }
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            itemsInStock = try coreDataManager.mainManagedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("ERROR: \(error): \(error.userInfo)")
        }
        return itemsInStock
    }
    
    func loadItemsForStore() -> [Item] {
        var itemsInStore: [Item] = []
        guard let coreDataManager = coreDataManager else { return [] }
        
        let fetchReques: NSFetchRequest<Item> = Item.fetchRequest()
        fetchReques.predicate = NSPredicate(format: "%K != %@", #keyPath(Item.stock), "0")
        
        do {
            itemsInStore = try coreDataManager.mainManagedObjectContext.fetch(fetchReques)
        } catch let error as NSError {
            print("ERROR: \(error): \(error.userInfo)")
        }
        return itemsInStore
    }
    
}
