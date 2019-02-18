//
//  StockTableViewDataSource.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 04/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

extension BackEndViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemsInStock.count > 0 {
            tableView.separatorStyle = .singleLine
            emptyStoreLabel.isHidden = true
        } else {
            tableView.separatorStyle = .none
            emptyStoreLabel.isHidden = false
        }
        return itemsInStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        let itemForCell = itemsInStock[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.textLabel?.text = itemForCell.name
        cell.detailTextLabel?.text = itemForCell.stock
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let editItemViewController = EditItemViewController()
        
        // Pass an CoreDataStack instance, selectedItem and indexPath of selected item to the EditItemViewController
        editItemViewController.dataStorage = dataStorage
        editItemViewController.selectedItem = itemsInStock[indexPath.row]
        editItemViewController.indexPath = indexPath
        self.navigationController?.pushViewController(editItemViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let itemForDelete = itemsInStock[indexPath.row]
        
        if editingStyle == .delete {
            itemsInStock.remove(at: indexPath.row)
            dataStorage?.remove(itemForDelete)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            navigationItem.title = "Колличесвто позиций: \(itemsInStock.count)"
        }
    }
}
