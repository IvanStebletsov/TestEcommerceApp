//
//  StandardTableViewCell.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 04/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

class ItemNameTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let textField = UITextField()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)]
        NSLayoutConstraint.activate(textFieldConstraints)
        
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Как называется товар?"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
