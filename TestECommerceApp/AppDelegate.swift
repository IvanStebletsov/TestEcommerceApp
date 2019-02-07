//
//  AppDelegate.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 04/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    var window: UIWindow?
    private let coreDataManager = CoreDataManager(modelName: "TestECommerceApp")
    private let dataStoreAdapter = DataStoreAdapter()
    
    // MARK: - Application lifecicle methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Preloading data from CSV when you first start the app
        importCSVDataIfNeeded()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white

        let storeViewController = StoreViewController()
        let backEndViewController = UINavigationController(rootViewController: BackEndViewController())
        let appScreenControllers = [storeViewController, backEndViewController]
        
        // Pass an CoreDataStack instance to the initial ViewController (StoreViewController)
        dataStoreAdapter.coreDataManager = coreDataManager
        storeViewController.dataStoreAdapter = dataStoreAdapter
        
        let tabBarViewController = UITabBarController()
        tabBarViewController.tabBar.tintColor = UIColor(r: 70, g: 155, b: 252, alpha: 1)
        tabBarViewController.viewControllers = appScreenControllers
        
        storeViewController.tabBarItem = UITabBarItem(title: "Store-Front", image: UIImage(named: "Store-Front"), selectedImage: nil)
        backEndViewController.tabBarItem = UITabBarItem(title: "Back-End", image: UIImage(named: "Back-End"), selectedImage: nil)
        
        window?.rootViewController = tabBarViewController

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { coreDataManager.saveChanges() }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { coreDataManager.saveChanges() }
    
    
    // MARK: - Importing data
    // Check if there are no elements in CoreData, so we parse the CSV file and import the data into CoreData
    func importCSVDataIfNeeded() {
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        let count = try! coreDataManager.mainManagedObjectContext.count(for: fetchRequest)

        guard count == 0 else { return }
        do {
            let results = try coreDataManager.mainManagedObjectContext.fetch(fetchRequest)
            results.forEach { coreDataManager.mainManagedObjectContext.delete($0) }

            coreDataManager.saveChanges()
            importCSVData()

        } catch let error as NSError {
            print("Error fetching: \(error), \(error.userInfo)")
        }
    }

    // Parse CSV, create managedObjects and save into CoreData
    func importCSVData() {
        let csvURL = Bundle.main.url(forResource: "data", withExtension: "csv")!
        let csvLines = try! String(contentsOf: csvURL, encoding: .utf8).components(separatedBy: "\n")

        for line in csvLines {
            var lineComponents = line.components(separatedBy: ",")
            guard lineComponents.count >= 3 else { return }
            let itemName = lineComponents[0].trimmingCharacters(in: CharacterSet(charactersIn: "\""))
            let itemPrice = Double(lineComponents[1].trimmingCharacters(in: CharacterSet(charactersIn: "01234567890.").inverted))
            let itemStock = lineComponents[2].trimmingCharacters(in: CharacterSet(charactersIn: "01234567890").inverted)

            let item = Item(context: coreDataManager.mainManagedObjectContext)
            item.name = itemName
            item.price = String(itemPrice!)
            item.stock = itemStock
        }
        coreDataManager.saveChanges()
    }
}


