//
//  StoreItemCardCollectionViewCell.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 06/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

class StoreItemCardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    let itemCardBackgroundBorderColor = UIColor(r: 70, g: 155, b: 252, alpha: 1)
    let buyButtonColor = UIColor(r: 70, g: 155, b: 252, alpha: 1)
    
    // MARK: - UI elements
    private var itemCardBackgroundView: UIView!
    var buyButton: UIButton!
    private var itemCardStackView: UIStackView!
    
    private var nameAssembledView: UIView!
    private var nameStackView: UIStackView!
    var nameHeaderLabel: UILabel!
    var nameLabel: UILabel!
    
    private var stockAssembledView: UIView!
    private var stockStackView: UIStackView!
    var stockHeaderLabel: UILabel!
    var stockLabel: UILabel!
    
    private var priceAssembledView: UIView!
    private var priceStackView: UIStackView!
    var priceHeaderLabel: UILabel!
    var priceLabel: UILabel!
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        setupItemCardBackgroundView()
        setupBuyButton()
        setupItemCardStackView()
        setupItemNameAssembledElement()
        setupItemStockAssembledElement()
        setupItemPriceAssembledElement()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI configuration
    private func setupItemCardBackgroundView() {
        itemCardBackgroundView = UIView()
        itemCardBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        itemCardBackgroundView.backgroundColor = .white
        itemCardBackgroundView.layer.cornerRadius = 25
        itemCardBackgroundView.layer.borderColor = itemCardBackgroundBorderColor.cgColor
        itemCardBackgroundView.layer.borderWidth = 1.5
        itemCardBackgroundView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        itemCardBackgroundView.layer.shadowOpacity = 0.2
        itemCardBackgroundView.layer.shadowRadius = 10
        itemCardBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.addSubview(itemCardBackgroundView)
        
        let itemCardBackgroundViewConstraints = [
            itemCardBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            itemCardBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            itemCardBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            itemCardBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)]
        NSLayoutConstraint.activate(itemCardBackgroundViewConstraints)
    }
    
    private func setupBuyButton() {
        buyButton = UIButton()
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.backgroundColor = buyButtonColor
        buyButton.setTitle("КУПИТЬ", for: .normal)
        buyButton.setTitleColor(#colorLiteral(red: 0.6049375534, green: 0.7886608243, blue: 0.9924311042, alpha: 1), for: .highlighted)
        buyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        buyButton.layer.cornerRadius = 15
        buyButton.layer.shadowColor = buyButtonColor.cgColor
        buyButton.layer.shadowOpacity = 0.5
        buyButton.layer.shadowRadius = 10
        buyButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.addSubview(buyButton)
        
        let buyButtonConstraints = [
            buyButton.heightAnchor.constraint(equalToConstant: 60),
            buyButton.widthAnchor.constraint(equalToConstant: 200),
            buyButton.bottomAnchor.constraint(equalTo: itemCardBackgroundView.bottomAnchor, constant: 25),
            buyButton.centerXAnchor.constraint(equalTo: itemCardBackgroundView.centerXAnchor)]
        NSLayoutConstraint.activate(buyButtonConstraints)
    }
    
    private func setupItemCardStackView() {
        itemCardStackView = UIStackView()
        itemCardStackView.translatesAutoresizingMaskIntoConstraints = false
        itemCardStackView.axis = .vertical
        itemCardStackView.distribution = .fillEqually
        itemCardStackView.alignment = .center
        itemCardStackView.spacing = 15
        
        itemCardBackgroundView.addSubview(itemCardStackView)
        
        let itemCardStackViewConstraints = [
            itemCardStackView.topAnchor.constraint(equalTo: itemCardBackgroundView.topAnchor, constant: 15),
            itemCardStackView.bottomAnchor.constraint(lessThanOrEqualTo: buyButton.topAnchor, constant: -15),
            itemCardStackView.heightAnchor.constraint(equalTo: itemCardBackgroundView.heightAnchor, multiplier: 0.8),
            itemCardStackView.leadingAnchor.constraint(equalTo: itemCardBackgroundView.leadingAnchor, constant: 5),
            itemCardStackView.trailingAnchor.constraint(equalTo: itemCardBackgroundView.trailingAnchor, constant: -5)]
        NSLayoutConstraint.activate(itemCardStackViewConstraints)
    }
    
    private func setupItemNameAssembledElement() {
        nameAssembledView = UIView()
        
        itemCardStackView.addArrangedSubview(nameAssembledView)
        
        nameStackView = UIStackView()
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.axis = .vertical
        nameStackView.distribution = .fillProportionally
        nameStackView.spacing = 5
        nameStackView.alignment = .center
        
        nameAssembledView.addSubview(nameStackView)
        
        let nameStackViewConstraints = [
            nameStackView.leadingAnchor.constraint(equalTo: nameAssembledView.leadingAnchor),
            nameStackView.trailingAnchor.constraint(equalTo: nameAssembledView.trailingAnchor),
            nameStackView.centerYAnchor.constraint(equalTo: nameAssembledView.centerYAnchor)]
        NSLayoutConstraint.activate(nameStackViewConstraints)
        
        nameHeaderLabel = UILabel()
        nameHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        nameHeaderLabel.textAlignment = .center
        nameHeaderLabel.font = .systemFont(ofSize: 12)
        nameHeaderLabel.textColor = #colorLiteral(red: 0.4665635824, green: 0.46639961, blue: 0.4829245806, alpha: 1)
        nameHeaderLabel.text = "НАИМЕНОВАНИЕ ТОВАРА"
        
        nameStackView.addArrangedSubview(nameHeaderLabel)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.text = "Apple MacBook 15\" 2018 Core i7-7430, 8 GB, 512 GB SSD"
        nameLabel.numberOfLines = 0

        nameStackView.addArrangedSubview(nameLabel)
    }
    
    private func setupItemStockAssembledElement() {
        stockAssembledView = UIView()
        
        itemCardStackView.addArrangedSubview(stockAssembledView)
        
        stockStackView = UIStackView()
        stockStackView.translatesAutoresizingMaskIntoConstraints = false
        stockStackView.axis = .vertical
        stockStackView.distribution = .fillProportionally
        stockStackView.spacing = 5
        stockStackView.alignment = .center
        
        stockAssembledView.addSubview(stockStackView)
        
        let stockStackViewConstraints = [
            stockStackView.leadingAnchor.constraint(equalTo: stockAssembledView.leadingAnchor),
            stockStackView.trailingAnchor.constraint(equalTo: stockAssembledView.trailingAnchor),
            stockStackView.centerYAnchor.constraint(equalTo: stockAssembledView.centerYAnchor)]
        NSLayoutConstraint.activate(stockStackViewConstraints)
        
        stockHeaderLabel = UILabel()
        stockHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        stockHeaderLabel.textAlignment = .center
        stockHeaderLabel.font = .systemFont(ofSize: 12)
        stockHeaderLabel.textColor = #colorLiteral(red: 0.4665635824, green: 0.46639961, blue: 0.4829245806, alpha: 1)
        stockHeaderLabel.text = "КОЛИЧЕСВТО ТОВАРА В НАЛИЧИИ"
        
        stockStackView.addArrangedSubview(stockHeaderLabel)
        
        stockLabel = UILabel()
        stockLabel.translatesAutoresizingMaskIntoConstraints = false
        stockLabel.textAlignment = .center
        stockLabel.font = .boldSystemFont(ofSize: 20)
        
        stockStackView.addArrangedSubview(stockLabel)
    }
    
    private func setupItemPriceAssembledElement() {
        priceAssembledView = UIView()
        
        itemCardStackView.addArrangedSubview(priceAssembledView)
        
        priceStackView = UIStackView()
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.axis = .vertical
        priceStackView.distribution = .fillProportionally
        priceStackView.spacing = 5
        priceStackView.alignment = .center
        
        priceAssembledView.addSubview(priceStackView)
        
        let priceStackViewConstraints = [
            priceStackView.leadingAnchor.constraint(equalTo: priceAssembledView.leadingAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: priceAssembledView.trailingAnchor),
            priceStackView.centerYAnchor.constraint(equalTo: priceAssembledView.centerYAnchor)]
        NSLayoutConstraint.activate(priceStackViewConstraints)
        
        priceHeaderLabel = UILabel()
        priceHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        priceHeaderLabel.textAlignment = .center
        priceHeaderLabel.font = .systemFont(ofSize: 12)
        priceHeaderLabel.textColor = #colorLiteral(red: 0.4665635824, green: 0.46639961, blue: 0.4829245806, alpha: 1)
        priceHeaderLabel.text = "ЦЕНА"
        
        priceStackView.addArrangedSubview(priceHeaderLabel)
        
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .center
        priceLabel.font = .boldSystemFont(ofSize: 20)
        
        priceStackView.addArrangedSubview(priceLabel)
    }
}
