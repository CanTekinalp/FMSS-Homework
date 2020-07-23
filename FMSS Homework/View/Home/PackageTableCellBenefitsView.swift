//
//  PackageTableCellBenefitsView.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 22.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

final class PackageTableCellBenefitsView: UIView {
    
    var packageViewModel: PackageViewModel? {
        didSet {
            createStackViewContents()
        }
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.backgroundColor = .clear
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createStackViewContents() {
        stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        packageViewModel?.benefits?.forEach {
            let imageView = UIImageView(image: $0)
            imageView.setWidthAnchor(to: 25)
            imageView.setHeightAnchor(to: 25)
            stackView.addArrangedSubview(imageView)
        }
    }
}

extension PackageTableCellBenefitsView {
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.fillSuperView()
    }
}
