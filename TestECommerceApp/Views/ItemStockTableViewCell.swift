//
//  ItemStockTableViewCell.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 04/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

class ItemStockTableViewCell: UITableViewCell {

    // MARK: - UI elements
    var textField: UITextField!
    var stockCountStepper: UIStepper!
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStockCountStepper()
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI configuration
    private func setupTextField() {
        textField = UITextField()
        
        self.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: stockCountStepper.leadingAnchor, constant: -5)]
        NSLayoutConstraint.activate(textFieldConstraints)
        
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Сколько товара в наличии?"
        textField.keyboardType = .numberPad
    }
    
    private func setupStockCountStepper() {
        stockCountStepper = UIStepper()
        stockCountStepper.minimumValue = -1
        stockCountStepper.value = 0
        stockCountStepper.maximumValue = 1
        
        self.addSubview(stockCountStepper)
        
        stockCountStepper.translatesAutoresizingMaskIntoConstraints = false
        let stockCountStepperConstraints = [
            stockCountStepper.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stockCountStepper.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)]
        NSLayoutConstraint.activate(stockCountStepperConstraints)
        
        stockCountStepper.addTarget(self, action: #selector(stepperSetValue), for: .valueChanged)
    }
    
    
    @objc func stepperSetValue(sender: UIStepper!) {
        let stockCountStepperValue = Int(sender.value)
        if let _ = Int(textField.text!) {
 
        } else {
            textField.text = "0"
        }
        
        switch stockCountStepperValue {
        case 1:
            textField.text = String(Int(textField.text!)! + 1)
            sender.value = 0
        case -1:
            guard Int(textField.text!)! > 0 else { textField.text = "0"; return }
            textField.text = String(Int(textField.text!)! - 1)
            sender.value = 0
        default:
            break
        }
    }
}
