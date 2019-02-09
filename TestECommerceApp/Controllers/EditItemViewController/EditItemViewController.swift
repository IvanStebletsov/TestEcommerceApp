//
//  EditItemViewController.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 04/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit
import CoreData

class EditItemViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    let itemNameTableViewCell = ItemNameTableViewCell()
    let itemPriceTableViewCell = ItemPriceTableViewCell()
    let itemStockTableViewCell = ItemStockTableViewCell()
    var dataStoreAdapter: SaveData?
    var selectedItem: Item?
    var indexPath: IndexPath?
    var activeField: UITextField?
    
    // MARK: - UI elements
    var editFormTableView: UITableView!
    
    // MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9370916486, green: 0.9369438291, blue: 0.9575446248, alpha: 1)
        
        makeAddEditFormTableView()
        makeSaveBarButton()
        makeDoneButtonInNumPad(textField: itemPriceTableViewCell.textField)
        makeDoneButtonInNumPad(textField: itemStockTableViewCell.textField)
        addTargetForTextFields()
        addTargetForStepper()
        setupKeyboardObserver()
        hideKeyboardByTapAnywhere()
        
        if let selectedItem = selectedItem {
            navigationItem.title = selectedItem.name
            itemNameTableViewCell.textField.text = selectedItem.name
            itemPriceTableViewCell.textField.text = selectedItem.price
            itemStockTableViewCell.textField.text = selectedItem.stock
        }
    }
}
