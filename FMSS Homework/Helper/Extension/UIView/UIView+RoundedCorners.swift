//
//  UIView+RoundedCorners.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 24.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

extension UIView {
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
