//
//  ContainerView.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

final class RoundedShadowContainerView: UIView {
    
    private let shadowData: ShadowData
    
    init(shadowData: ShadowData) {
        self.shadowData = shadowData
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.drawShadow(shadowData: shadowData)
    }
}

struct ShadowData {
    let cornerRadius: CGFloat
    let shadowColor: UIColor
    let alpha: Float
    let offset: CGSize
    let blur: CGFloat?
    
    init(cornerRadius: CGFloat,
         shadowColor: UIColor,
         alpha: Float,
         offset: CGSize,
         blur: CGFloat? = nil)
    {
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.alpha = alpha
        self.offset = offset
        self.blur = blur
    }
}
