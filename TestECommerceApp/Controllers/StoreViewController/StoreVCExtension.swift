//
//  StoreVCExtension.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 06/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit


extension StoreViewController {
    
    // MARK: - UI configuration
    func makeSwipeCollectionView() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        swipeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        swipeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        swipeCollectionView.backgroundColor = .clear
        swipeCollectionView.isPagingEnabled = true
        swipeCollectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(swipeCollectionView)
        
        swipeCollectionView.register(StoreItemCardCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        swipeCollectionView.delegate = self
        swipeCollectionView.dataSource = self
        
        let safeArea = view.safeAreaLayoutGuide
        let swipeCollectionViewConstraints = [
            swipeCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            swipeCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            swipeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swipeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        NSLayoutConstraint.activate(swipeCollectionViewConstraints)
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
        text.text = "В данный момент в магазине ничего нет, но в скором времени что-нибудь появится."
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
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        
        let gradientStatusBar = UIImageView()
        gradientStatusBar.translatesAutoresizingMaskIntoConstraints = false
        gradientStatusBar.image = UIImage(named: "GradientStatusBar")
        
        view.insertSubview(backgroundImage, at: 0)
        backgroundImage.addSubview(gradientStatusBar)
        
        let backgroundImageConstraints = [backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
                                          backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                          backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                          backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        NSLayoutConstraint.activate(backgroundImageConstraints)
        
        let gradientStatusBarConstraints = [
            gradientStatusBar.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            gradientStatusBar.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            gradientStatusBar.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            gradientStatusBar.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor),
            gradientStatusBar.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor, multiplier: 0.05)]
        NSLayoutConstraint.activate(gradientStatusBarConstraints)
    }
    
    // MARK: - Action for button
    @objc func buyItem(sender: UIButton) {
        let buttonPoint = sender.convert(sender.bounds.origin, to: swipeCollectionView)
        indexPath = swipeCollectionView.indexPathForItem(at: buttonPoint)!
        
        guard indexPath.row <= itemsInStore.count - 1 else { return }
        
        let boughtItem = itemsInStore[indexPath.row]
        
        guard let count = Int(boughtItem.stock!) else { return }
        
        if count > 1 {
            boughtItem.stock = "\(count - 1)"
            swipeCollectionView.reloadItems(at: [indexPath])
        } else {
            boughtItem.stock = "\(count - 1)"
            itemsInStore.remove(at: indexPath.row)
            swipeCollectionView.reloadData()
        }
        
        dataStoreAdapter?.save()
        
        let alert = UIAlertController(title: "Вы купили \(boughtItem.name ?? "классную вещь!")", message: "Поздравляем с приобретением!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ура!", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
            self.swipeCollectionView.reloadData()
            self.emptyStoreLabel.isHidden = self.itemsInStore.count > 0 ? true : false
        })
    }
}
