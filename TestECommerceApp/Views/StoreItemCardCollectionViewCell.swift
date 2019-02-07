//
//  StoreItemCardCollectionViewCell.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 06/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

class StoreItemCardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(itemCardBackground)
        self.addSubview(buyButton)
        
        self.addSubview(itemNameLabelHeader)
        self.addSubview(itemNameLabel)
        
        self.addSubview(itemInStockLabelHeader)
        self.addSubview(itemInStockLabel)
        
        self.addSubview(itemPriceLabelHeader)
        self.addSubview(itemPriceLabel)
        
        let itemCardBackgroundConstraints = [
            itemCardBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            itemCardBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            itemCardBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            itemCardBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)]
        NSLayoutConstraint.activate(itemCardBackgroundConstraints)
        
        let buyButtonConstraints = [
            buyButton.heightAnchor.constraint(equalToConstant: 60),
            buyButton.widthAnchor.constraint(equalToConstant: 200),
            buyButton.bottomAnchor.constraint(equalTo: itemCardBackground.bottomAnchor, constant: 25),
            buyButton.centerXAnchor.constraint(equalTo: itemCardBackground.centerXAnchor)]
        NSLayoutConstraint.activate(buyButtonConstraints)
        
        let itemNameLabelConstraints = [
            itemNameLabelHeader.topAnchor.constraint(equalTo: itemCardBackground.topAnchor, constant: 40),
            itemNameLabelHeader.centerXAnchor.constraint(equalTo: itemCardBackground.centerXAnchor),
            itemNameLabel.topAnchor.constraint(equalTo: itemNameLabelHeader.bottomAnchor, constant: 5),
            itemNameLabel.leadingAnchor.constraint(equalTo: itemCardBackground.leadingAnchor, constant: 10),
            itemNameLabel.trailingAnchor.constraint(equalTo: itemCardBackground.trailingAnchor, constant: -10)]
        NSLayoutConstraint.activate(itemNameLabelConstraints)
        
        let itemInStockLabelConstraints = [
            itemInStockLabelHeader.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 40),
            itemInStockLabelHeader.centerXAnchor.constraint(equalTo: itemCardBackground.centerXAnchor),
            itemInStockLabel.topAnchor.constraint(equalTo: itemInStockLabelHeader.bottomAnchor, constant: 5),
            itemInStockLabel.leadingAnchor.constraint(equalTo: itemCardBackground.leadingAnchor, constant: 10),
            itemInStockLabel.trailingAnchor.constraint(equalTo: itemCardBackground.trailingAnchor, constant: -10)]
        NSLayoutConstraint.activate(itemInStockLabelConstraints)
        
        let itemPriceConstraints = [
            itemPriceLabelHeader.topAnchor.constraint(equalTo: itemInStockLabel.bottomAnchor, constant: 40),
            itemPriceLabelHeader.centerXAnchor.constraint(equalTo: itemCardBackground.centerXAnchor),
            itemPriceLabel.topAnchor.constraint(equalTo: itemPriceLabelHeader.bottomAnchor, constant: 5),
            itemPriceLabel.leadingAnchor.constraint(equalTo: itemCardBackground.leadingAnchor, constant: 10),
            itemPriceLabel.trailingAnchor.constraint(equalTo: itemCardBackground.trailingAnchor, constant: -10)]
        NSLayoutConstraint.activate(itemPriceConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Background of item card
    private let itemCardBackground: UIView = {
        let itemCardBackground = UIView()
        let itemCardBackgroundColor = UIColor(r: 70, g: 155, b: 252, alpha: 1)
        
        itemCardBackground.translatesAutoresizingMaskIntoConstraints = false
        itemCardBackground.backgroundColor = .white
        itemCardBackground.layer.cornerRadius = 25
        itemCardBackground.layer.borderColor = itemCardBackgroundColor.cgColor
        itemCardBackground.layer.borderWidth = 1.5
        itemCardBackground.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        itemCardBackground.layer.shadowOpacity = 0.2
        itemCardBackground.layer.shadowRadius = 10
        itemCardBackground.layer.shadowOffset = CGSize(width: 0, height: 0)
        return itemCardBackground
    }()
    
    // MARK: - Labels of Item's attributes
    // Labels for Item Name
    private let itemNameLabelHeader: UILabel = {
        let itemNameLabelHeader = UILabel()
        itemNameLabelHeader.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabelHeader.textAlignment = .center
        itemNameLabelHeader.font = .systemFont(ofSize: 12)
        itemNameLabelHeader.textColor = #colorLiteral(red: 0.4665635824, green: 0.46639961, blue: 0.4829245806, alpha: 1)
        itemNameLabelHeader.text = "НАИМЕНОВАНИЕ ТОВАРА"
        return itemNameLabelHeader
    }()
    
    lazy var itemNameLabel: UILabel = {
        let itemNameLabel = UILabel()
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.textAlignment = .center
        itemNameLabel.font = .boldSystemFont(ofSize: 20)
        itemNameLabel.text = "Apple MacBook 15\" 2018 Core i7-7430, 8 GB, 512 GB SSD"
        itemNameLabel.numberOfLines = 0
        return itemNameLabel
    }()
    
    // Labels for count of items in stock
    private let itemInStockLabelHeader: UILabel = {
        let itemNameLabelHeader = UILabel()
        itemNameLabelHeader.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabelHeader.textAlignment = .center
        itemNameLabelHeader.font = .systemFont(ofSize: 12)
        itemNameLabelHeader.textColor = #colorLiteral(red: 0.4665635824, green: 0.46639961, blue: 0.4829245806, alpha: 1)
        itemNameLabelHeader.text = "КОЛИЧЕСВТО ТОВАРА В НАЛИЧИИ"
        return itemNameLabelHeader
    }()
    
    lazy var itemInStockLabel: UILabel = {
        let itemInStockLabel = UILabel()
        itemInStockLabel.translatesAutoresizingMaskIntoConstraints = false
        itemInStockLabel.textAlignment = .center
        itemInStockLabel.font = .boldSystemFont(ofSize: 20)
        return itemInStockLabel
    }()
    
    // Labels for items price
    private let itemPriceLabelHeader: UILabel = {
        let itemPriceLabelHeader = UILabel()
        itemPriceLabelHeader.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabelHeader.textAlignment = .center
        itemPriceLabelHeader.font = .systemFont(ofSize: 12)
        itemPriceLabelHeader.textColor = #colorLiteral(red: 0.4665635824, green: 0.46639961, blue: 0.4829245806, alpha: 1)
        itemPriceLabelHeader.text = "ЦЕНА"
        return itemPriceLabelHeader
    }()
    
    lazy var itemPriceLabel: UILabel = {
        let itemPriceLabel = UILabel()
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.textAlignment = .center
        itemPriceLabel.font = .boldSystemFont(ofSize: 20)
        return itemPriceLabel
    }()
    
    // MARK: - Buy button
    private let buyButton: UIButton = {
        let buyButton = UIButton()
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        let buttonColor = UIColor(r: 70, g: 155, b: 252, alpha: 1)
        buyButton.backgroundColor = buttonColor
        buyButton.setTitle("КУПИТЬ", for: .normal)
        buyButton.setTitleColor(#colorLiteral(red: 0.6049375534, green: 0.7886608243, blue: 0.9924311042, alpha: 1), for: .highlighted)
        buyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        buyButton.layer.cornerRadius = 15
        buyButton.layer.shadowColor = buttonColor.cgColor
        buyButton.layer.shadowOpacity = 0.5
        buyButton.layer.shadowRadius = 10
        buyButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        buyButton.addTarget(self, action: #selector(StoreViewController.buyItem), for: .touchUpInside)
        return buyButton
    }()

}
