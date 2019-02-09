//
//  EditItemVCExtension.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 04/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit
import CoreData

extension EditItemViewController {
    
    // MARK: - UI configuration
    func makeAddEditFormTableView() {
        
        editFormTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        editFormTableView.separatorStyle = .none
        editFormTableView.translatesAutoresizingMaskIntoConstraints = false
        editFormTableView.rowHeight = 44
        editFormTableView.backgroundColor = .clear
        
        view.addSubview(editFormTableView)
        
        editFormTableView.delegate = self
        editFormTableView.dataSource = self
        
        let safeArea = view.safeAreaLayoutGuide
        let addEditFormTableViewConstraints = [
            editFormTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            editFormTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            editFormTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            editFormTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)]
        NSLayoutConstraint.activate(addEditFormTableViewConstraints)
    }
    
    func makeDoneButtonInNumPad(textField: UITextField) {
        let numpadToolbar = UIToolbar()
        let accessoryView = UIView()
        
        let toolBarDoneButton = UIBarButtonItem(title: "Готово",
                                                style: .done,
                                                target: self,
                                                action: #selector(dismissKeyboard))
        
        let toolBarFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                   target: nil,
                                                   action: nil)
        
        numpadToolbar.setItems([toolBarFlexibleSpace, toolBarDoneButton], animated: true)
        numpadToolbar.translatesAutoresizingMaskIntoConstraints = false
        accessoryView.addSubview(numpadToolbar)
        numpadToolbar.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor).isActive = true
        numpadToolbar.leadingAnchor.constraint(equalTo: accessoryView.leadingAnchor).isActive = true
        numpadToolbar.trailingAnchor.constraint(equalTo: accessoryView.trailingAnchor).isActive = true
        
        textField.inputAccessoryView = numpadToolbar
    }
    
    func makeSaveBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveData))
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(popViewController))
    }
    
    // MARK: - Keyboard handling
    func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // Get the height of the keyboard, its Duration and Curve of the animation when it appears and animate the shift editFormTableView up with the resulting parameters to leave access to the text fields
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
        guard let keyboardAnimationCurveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        let contentAnimationCurve = UIView.AnimationOptions(rawValue: UIView.AnimationOptions.RawValue(truncating: keyboardAnimationCurveRaw))
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: contentAnimationCurve,
                       animations: {
                        self.editFormTableView.contentInset = contentInsets
                        self.editFormTableView.scrollIndicatorInsets = contentInsets
                        
                        var contentRect = self.view.frame
                        contentRect.size.height -= keyboardSize.height
                        
                        guard let activeField = self.activeField else { return }
                        if contentRect.contains(activeField.frame.origin) {
                            self.editFormTableView.scrollRectToVisible(activeField.frame, animated: true) } },
                       completion: nil)
    }
    
    // Get the Duration and animation Curve of the disappearance of the keyboard and animate removing the offset of the editFormTableView with received parameters
    @objc func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
        guard let keyboardAnimationCurveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        let contentAnimationCurve = UIView.AnimationOptions(rawValue: UIView.AnimationOptions.RawValue(truncating: keyboardAnimationCurveRaw))
        
        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: contentAnimationCurve,
                       animations: {
                        self.editFormTableView.contentInset = .zero
                        self.editFormTableView.scrollIndicatorInsets = .zero
                        self.view.resignFirstResponder() },
                       completion: nil)
    }
    
    func hideKeyboardByTapAnywhere() {
        editFormTableView.keyboardDismissMode = .interactive
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        editFormTableView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - TextFields handling
    func addTargetForTextFields() {
        itemNameTableViewCell.textField.delegate = self
        itemPriceTableViewCell.textField.delegate = self
        itemStockTableViewCell.textField.delegate = self
        
        itemNameTableViewCell.textField.addTarget(self,
                                                  action: #selector(enableTheSaveButton),
                                                  for: UIControl.Event.editingChanged)
        itemPriceTableViewCell.textField.addTarget(self,
                                                   action: #selector(enableTheSaveButton),
                                                   for: UIControl.Event.editingChanged)
        itemStockTableViewCell.textField.addTarget(self, action: #selector(enableTheSaveButton),
                                                   for: UIControl.Event.editingChanged)
    }
    
    func addTargetForStepper() {
        itemStockTableViewCell.stockCountStepper.addTarget(self, action: #selector(enableTheSaveButton), for: .valueChanged)
    }
    
    @objc func enableTheSaveButton(target: Any) {
        navigationItem.title = itemNameTableViewCell.textField.text?.correctTheInputText()
        
        let itemName = itemNameTableViewCell.textField.text!
        var itemPrice = itemPriceTableViewCell.textField.text!
        var itemStock = itemStockTableViewCell.textField.text!
        
        if !itemPrice.isEmpty || !itemStock.isEmpty {
            itemPrice = itemPrice.correctTheInputNumber()
            itemPriceTableViewCell.textField.text? = itemPrice
            
            itemStock = itemStock.correctTheInputNumber()
            itemStockTableViewCell.textField.text = itemStock
        }
        
        // If indexPath is empty, we create new Item otherwise we edit and save existing item
        switch selectedItem {
        case nil:
            if itemName.isConformNameConditions() && itemPrice.isNumber() && itemStock.isNumber() {
                navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = false
            }
        default:
            if (itemName.isConformNameConditions() &&
                itemPrice.isNumber() &&
                itemStock.isNumber()) &&
                (itemName != selectedItem!.name! ||
                    itemPrice != selectedItem!.price! ||
                    itemStock != selectedItem!.stock!) {
                navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
    
    // Check the active text field for detect position for offset keyboard by call keyboardWillShow
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    // Uncheck the active text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let activeTextField = activeField else { return false }
        activeTextField.resignFirstResponder()
        return false
    }
    
    // MARK: - Save data
    @objc func saveData() {
        switch selectedItem {
        case nil:
            dataStoreAdapter?.saveNew(name: itemNameTableViewCell.textField.text!,
                                      price: itemPriceTableViewCell.textField.text!,
                                      stock: itemStockTableViewCell.textField.text!)
            popViewController()
        default:
            selectedItem?.name = itemNameTableViewCell.textField.text?.correctTheInputText()
            selectedItem?.price = itemPriceTableViewCell.textField.text?.correctTheInputNumber()
            selectedItem?.stock = itemStockTableViewCell.textField.text?.correctTheInputNumber()
            
            dataStoreAdapter?.save()
            popViewController()
        }
    }
    
    // MARK: - Navigation
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
}
