//
//  SortOrderViewCollectionCell.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 23.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

final class SortOrderViewCollectionCell: UICollectionViewCell {
 
    static var cellIdentifier: String = {
        String(describing: type(of: self))
    }()
    
    var sortOrderViewModel: SortOrderViewModel? {
        didSet {
            titleLabel.text = sortOrderViewModel?.title
            if sortOrderViewModel?.isSelected == true {
                containerView.drawBorder()
                return
            }
            containerView.resetBorder()
        }
    }
    
    let containerView: RoundedShadowContainerView = {
        let shadowData = ShadowData(cornerRadius: 10, shadowColor: .black, alpha: 0.6, offset: .zero)
        let view = RoundedShadowContainerView(shadowData: shadowData)
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SortOrderViewCollectionCell {
    
    func setup() {
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
    }

    func setupConstraints() {
        let verticalPadding: CGFloat = 4
        let horizontalPadding: CGFloat = 8
        
        containerView.anchor(top: contentView.topAnchor,
                             leading: contentView.leadingAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             paddingTop: verticalPadding,
                             paddingleft: horizontalPadding,
                             paddingBottom: verticalPadding,
                             paddingRight: horizontalPadding,
                             width: 0, height: 0, centerX: nil, centerY: nil)
        
        titleLabel.fillSuperView()
    }
}
