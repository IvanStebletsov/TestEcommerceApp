//
//  BackEndVCExtension.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 04/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

extension BackEndViewController {
    
    // MARK: - UI configuration
    func makeStockTableView() {
        
        stockTableView = UITableView()
        stockTableView.translatesAutoresizingMaskIntoConstraints = false
        stockTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        stockTableView.rowHeight = 100
        stockTableView.backgroundColor = .clear
        
        view.addSubview(stockTableView)
        
        stockTableView.delegate = self
        stockTableView.dataSource = self
        
        let safeArea = view.safeAreaLayoutGuide
        let stockTableViewConstraints = [
            stockTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stockTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stockTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stockTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)]
        NSLayoutConstraint.activate(stockTableViewConstraints)
    }
    
    func makeEmptyStoreLabel() {
        emptyStoreLabel = UIView()
        emptyStoreLabel.translatesAutoresizingMaskIntoConstraints = false
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        emptyStoreLabel.backgroundColor = UIColor(r: 192, g: 208, b: 222, alpha: 0.7)
        emptyStoreLabel.layer.masksToBounds = true
        emptyStoreLabel.layer.cornerRadius = 15
        text.textAlignment = .center
        text.numberOfLines = 0
        text.text = "В данный момент не добавлено ни одной позиции"
        text.textColor = #colorLiteral(red: 0.4665635824, green: 0.46639961, blue: 0.4829245806, alpha: 1)
        
        view.addSubview(emptyStoreLabel)
        emptyStoreLabel.addSubview(text)
        
        let emptyStoreLabelConstraints = [
            emptyStoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emptyStoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emptyStoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: emptyStoreLabel.leadingAnchor, constant: 10),
            text.trailingAnchor.constraint(equalTo: emptyStoreLabel.trailingAnchor, constant: -10),
            text.topAnchor.constraint(equalTo: emptyStoreLabel.topAnchor, constant: 10),
            text.bottomAnchor.constraint(equalTo: emptyStoreLabel.bottomAnchor, constant: -10)]
        NSLayoutConstraint.activate(emptyStoreLabelConstraints)
    }
    
    func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    // MARK: - Action for button
    @objc func addNewItem() {
        let editItemViewController = EditItemViewController()
        
        // Pass an CoreDataStack instance to the EditItemViewController and wipe (nil) selectedItem and indexPath of selected item
        editItemViewController.dataStoreAdapter = dataStoreAdapter
        editItemViewController.selectedItem = nil
        editItemViewController.indexPath = nil
        self.navigationController?.pushViewController(editItemViewController, animated: true)
    }
    
}
