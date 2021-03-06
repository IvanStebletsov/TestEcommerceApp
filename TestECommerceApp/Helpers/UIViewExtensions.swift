//
//  UIViewExtensions.swift
//  TestECommerceApp
//
//  Created by Ivan Stebletsov on 07/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

extension UIView {
    
    func setGradientBackground(ColorOne: UIColor, ColorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [ColorOne.cgColor, ColorTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
