//
//  UIView+Border.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 22.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

extension UIView {
    
    func drawBorder(color: UIColor = .cheese, width: CGFloat = 2) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func resetBorder() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
    }
}
