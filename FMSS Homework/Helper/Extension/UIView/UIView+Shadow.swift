//
//  UIView+Shadow.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

extension UIView {
    
    func drawShadow(shadowData : ShadowData) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowData.shadowColor.cgColor
        self.layer.shadowOpacity = shadowData.alpha
        self.layer.shadowOffset = shadowData.offset
        
        if let blur = shadowData.blur {
            self.layer.shadowRadius = blur / 2.0
        }
        
        if shadowData.cornerRadius != 0 {
            self.layer.shadowPath = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: shadowData.cornerRadius).cgPath
        } else {
            self.layer.shadowPath = UIBezierPath(rect: self.layer.bounds).cgPath
        }
    }
}
