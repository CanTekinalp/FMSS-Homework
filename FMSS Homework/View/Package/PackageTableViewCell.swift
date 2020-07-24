//
//  PackageTableViewCell.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

protocol PackageTableViewCellDelegate: NSObjectProtocol {
    func didClickFavouriteButton()
}

final class PackageTableViewCell: UITableViewCell {

    static var cellIdentifier: String = {
        String(describing: type(of: self))
    }()

    weak var delegate: PackageTableViewCellDelegate?
    
    var packageViewModel: PackageViewModel? {
        didSet {
            nameLabel.text = packageViewModel?.name
            subscriptionTypeLabel.text = packageViewModel?.subscriptionTypeText
            descriptionLabel.text = packageViewModel?.description
            priceLabel.text = packageViewModel?.price
            tariffView.packageViewModel = packageViewModel
            benefitsView.packageViewModel = packageViewModel
            didUseBeforeLabel.text = packageViewModel?.didUseBeforeText
            refreshButton()
        }
    }
    
    let containerView: RoundedShadowContainerView = {
        let shadowData = ShadowData(cornerRadius: 10, shadowColor: .black, alpha: 0.6, offset: .zero)
        let view = RoundedShadowContainerView(shadowData: shadowData)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let subscriptionTypeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let tariffView = PackageTableCellTariffView()
    
    lazy var favouriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .cheese
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleAddToFavouritesButton), for: .touchUpInside)
        return button
    }()
    
    let benefitsView = PackageTableCellBenefitsView()
    
    let didUseBeforeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func refreshButton() {
        favouriteButton.setTitle(packageViewModel?.favouriteButtonTitle, for: .normal)
        favouriteButton.backgroundColor = packageViewModel?.favouriteButtonColor
    }
    
    @objc private func handleAddToFavouritesButton() {
        guard let packageViewModel = packageViewModel else { return }
        packageViewModel.isFavourite = !packageViewModel.isFavourite
        let package = packageViewModel.package
        if packageViewModel.isFavourite {
            UserDefaults.standard.saveFavouritePackage(package: package)
        } else {
            UserDefaults.standard.removeFromFavouritePackages(package: package)
        }
        refreshButton()
        delegate?.didClickFavouriteButton()
    }
}

extension PackageTableViewCell {
    
    // MARK: Subview Setup
    private func setup() {
        setupSubviews()
        setupConstraints()
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(topStackView)
        topStackView.addArrangedSubview(nameLabel)
        topStackView.addArrangedSubview(subscriptionTypeLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(benefitsView)
        containerView.addSubview(tariffView)
        containerView.addSubview(didUseBeforeLabel)
        containerView.addSubview(favouriteButton)
    }
    
    private func setupConstraints() {
        let containerPadding: CGFloat = 25
        let horizontalPadding: CGFloat = 25

        containerView.anchor(top: contentView.topAnchor,
                             leading: contentView.leadingAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             paddingTop: containerPadding,
                             paddingleft: containerPadding,
                             paddingBottom: containerPadding,
                             paddingRight: containerPadding,
                             width: 0, height: 0, centerX: nil, centerY: nil)

        topStackView.anchor(top: containerView.topAnchor,
                            leading: containerView.leadingAnchor,
                            bottom: nil,
                            trailing: containerView.trailingAnchor,
                            paddingTop: 25, paddingleft: horizontalPadding, paddingBottom: 0, paddingRight: horizontalPadding,
                            width: 0, height: 0, centerX: nil, centerY: nil)
        
        descriptionLabel.anchor(top: nameLabel.bottomAnchor,
                                leading: containerView.leadingAnchor,
                                bottom: nil,
                                trailing: containerView.trailingAnchor,
                                paddingTop: 15, paddingleft: horizontalPadding, paddingBottom: 0, paddingRight: horizontalPadding,
                                width: 0, height: 0, centerX: nil, centerY: nil)
        
        didUseBeforeLabel.anchor(top: descriptionLabel.bottomAnchor,
                                 leading: containerView.leadingAnchor,
                                 bottom: nil,
                                 trailing: nil,
                                 paddingTop: 10, paddingleft: horizontalPadding, paddingBottom: 0, paddingRight: 0,
                                 width: 0, height: 0, centerX: nil, centerY: nil)
        
        priceLabel.anchor(top: didUseBeforeLabel.bottomAnchor,
                          leading: containerView.leadingAnchor,
                          bottom: nil,
                          trailing: nil,
                          paddingTop: 10, paddingleft: horizontalPadding, paddingBottom: 0, paddingRight: 0,
                          width: 0, height: 0, centerX: nil, centerY: nil)
        
        benefitsView.anchor(top: priceLabel.bottomAnchor,
                            leading: containerView.leadingAnchor,
                            bottom: nil,
                            trailing: nil,
                            paddingTop: 15, paddingleft: horizontalPadding, paddingBottom: 0, paddingRight: 0,
                            width: 0, height: 0, centerX: nil, centerY: nil)
        
        tariffView.anchor(top: descriptionLabel.bottomAnchor,
                          leading: nil,
                          bottom: nil,
                          trailing: containerView.trailingAnchor,
                          paddingTop: 15, paddingleft: 0, paddingBottom: 0, paddingRight: horizontalPadding,
                          width: 0, height: 0, centerX: nil, centerY: nil)
        
        favouriteButton.anchor(top: tariffView.bottomAnchor,
                               leading: nil,
                               bottom: containerView.bottomAnchor,
                               trailing: nil,
                               paddingTop: 35, paddingleft: 0, paddingBottom: 20, paddingRight: 0,
                               width: 250, height: 44, centerX: containerView.centerXAnchor, centerY: nil)
    }
}
