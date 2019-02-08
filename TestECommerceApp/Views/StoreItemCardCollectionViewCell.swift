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
        
        self.addSubview(stackView)
        
        // Assambled view with stackView inside with labels for itemNameLabel
        stackView.addArrangedSubview(itemNameLabelAssambledView)
        itemNameLabelAssambledView.addSubview(itemNameLabelStackView)
        itemNameLabelStackView.addArrangedSubview(itemNameLabelHeader)
        itemNameLabelStackView.addArrangedSubview(itemNameLabel)
        
        // Assambled view with stackView inside with labels for itemStockLabel
        stackView.addArrangedSubview(itemInStockLabelAssambledView)
        itemInStockLabelAssambledView.addSubview(itemInStockLabelStackView)
        itemInStockLabelStackView.addArrangedSubview(itemInStockLabelHeader)
        itemInStockLabelStackView.addArrangedSubview(itemInStockLabel)
        
        // Assambled view with stackView inside with labels for itemPriceLabel
        stackView.addArrangedSubview(itemPriceLabelAssambledView)
        itemPriceLabelAssambledView.addSubview(itemPriceLabelStackView)
        itemPriceLabelStackView.addArrangedSubview(itemPriceLabelHeader)
        itemPriceLabelStackView.addArrangedSubview(itemPriceLabel)

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
        
        let majorStackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: itemCardBackground.topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: itemCardBackground.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: itemCardBackground.trailingAnchor, constant: -5)]
        NSLayoutConstraint.activate(majorStackViewConstraints)
        
        let itemNameLabelStackViewConstraints = [
            itemNameLabelStackView.leadingAnchor.constraint(equalTo: itemNameLabelAssambledView.leadingAnchor),
            itemNameLabelStackView.trailingAnchor.constraint(equalTo: itemNameLabelAssambledView.trailingAnchor),
            itemNameLabelStackView.centerYAnchor.constraint(equalTo: itemNameLabelAssambledView.centerYAnchor)]
        NSLayoutConstraint.activate(itemNameLabelStackViewConstraints)
        
        let itemInStockLabelStackViewConstraints = [
            itemInStockLabelStackView.leadingAnchor.constraint(equalTo: itemInStockLabelAssambledView.leadingAnchor),
            itemInStockLabelStackView.trailingAnchor.constraint(equalTo: itemInStockLabelAssambledView.trailingAnchor),
            itemInStockLabelStackView.centerYAnchor.constraint(equalTo: itemInStockLabelAssambledView.centerYAnchor)]
        NSLayoutConstraint.activate(itemInStockLabelStackViewConstraints)
        
        let itemPriceLabelStackViewConstraints = [
            itemPriceLabelStackView.leadingAnchor.constraint(equalTo: itemPriceLabelAssambledView.leadingAnchor),
            itemPriceLabelStackView.trailingAnchor.constraint(equalTo: itemPriceLabelAssambledView.trailingAnchor),
            itemPriceLabelStackView.centerYAnchor.constraint(equalTo: itemPriceLabelAssambledView.centerYAnchor)]
        NSLayoutConstraint.activate(itemPriceLabelStackViewConstraints)
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
    // MARK: - StackViews of Item's attributes
    // StackView with labels for Item Name
    private let itemNameLabelAssambledView: UIView = {
        return UIView()
    }()
    
    private let itemNameLabelStackView: UIStackView = {
        let itemNameLabelStackView = UIStackView()
        itemNameLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabelStackView.axis = .vertical
        itemNameLabelStackView.distribution = .fillEqually
        itemNameLabelStackView.alignment = .center
        return itemNameLabelStackView
    }()
    
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
        itemNameLabel.numberOfLines = 2
        itemNameLabel.font = .boldSystemFont(ofSize: 20)
        itemNameLabel.text = "Apple MacBook 15\" 2018 Core i7-7430, 8 GB, 512 GB SSD"
        itemNameLabel.numberOfLines = 0
        return itemNameLabel
    }()
    
    // StackView with labels for items in stock
    private let itemInStockLabelAssambledView: UIView = {
        return UIView()
    }()
    
    private let itemInStockLabelStackView: UIStackView = {
        let itemInStockLabelStackView = UIStackView()
        itemInStockLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        itemInStockLabelStackView.axis = .vertical
        itemInStockLabelStackView.distribution = .fillEqually
        itemInStockLabelStackView.alignment = .center
        return itemInStockLabelStackView
    }()
    
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
    
    // StackView with labels for items in stock
    private let itemPriceLabelAssambledView: UIView = {
        return UIView()
    }()
    
    private let itemPriceLabelStackView: UIStackView = {
        let itemPriceLabelStackView = UIStackView()
        itemPriceLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabelStackView.axis = .vertical
        itemPriceLabelStackView.distribution = .fillEqually
        itemPriceLabelStackView.alignment = .center
        return itemPriceLabelStackView
    }()
    
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
