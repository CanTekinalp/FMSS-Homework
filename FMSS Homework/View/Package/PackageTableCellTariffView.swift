//
//  PackageTableCellTariffView.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 22.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

final class PackageTableCellTariffView: UIView {
    
    var packageViewModel: PackageViewModel? {
        didSet {
            dataLabel.text = packageViewModel?.dataText
            talkLabel.text = packageViewModel?.talkText
            smsLabel.text = packageViewModel?.smsText
        }
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.backgroundColor = .clear
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    let talkLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    let smsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PackageTableCellTariffView {
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(dataLabel)
        stackView.addArrangedSubview(talkLabel)
        stackView.addArrangedSubview(smsLabel)
    }
    
    private func setupConstraints() {
        stackView.fillSuperView()
    }
}
