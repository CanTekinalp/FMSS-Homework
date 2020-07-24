//
//  SortFilterOptionsView.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 24.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

protocol SortFilterOptionsViewDelegate: NSObjectProtocol {
    func didClickApplyFilterButton()
}

final class SortFilterOptionsView: UIView {

    weak var delegate: SortFilterOptionsViewDelegate?
    
    var sortFilterOptions: SortFilterOptions
    
    lazy var sortOrderView: SortOrderView = {
        let sortOrderView = SortOrderView()
        sortOrderView.sortOrderListViewModel = SortOrderListViewModel(sortFilterOptions.sortOrder)
        sortOrderView.delegate = self
        sortOrderView.backgroundColor = .doctor
        return sortOrderView
    }()
    
    lazy var tariffSortView: TariffSortView = {
        let tariffSortView = TariffSortView()
        tariffSortView.tariffListViewModel = TariffListViewModel(sortFilterOptions.tariffSortOption)
        tariffSortView.delegate = self
        tariffSortView.backgroundColor = .doctor
        return tariffSortView
    }()
    
    lazy var subscriptionTypeFilterView: SubscriptionFilterView = {
        let subscriptionTypeFilterView = SubscriptionFilterView()
        subscriptionTypeFilterView.subscriptionTypeListViewModel = SubscriptionTypeListViewModel(sortFilterOptions.subscriptionFilterOption)
        subscriptionTypeFilterView.delegate = self
        subscriptionTypeFilterView.backgroundColor = .doctor
        return subscriptionTypeFilterView
    }()
    
    lazy var applyFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Uygula", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .cheese
        button.addTarget(self, action: #selector(handleApplyFilterButton), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    @objc private func handleApplyFilterButton() {
        delegate?.didClickApplyFilterButton()
    }
    
    init(sortFilterOptions: SortFilterOptions) {
        self.sortFilterOptions = sortFilterOptions
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SortFilterOptionsView {
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(sortOrderView)
        addSubview(tariffSortView)
        addSubview(subscriptionTypeFilterView)
        addSubview(applyFilterButton)
    }
    
    private func setupConstraints() {
        let sectionHeight: CGFloat = 100

        sortOrderView.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: nil,
                             trailing: trailingAnchor,
                             paddingTop: 15, paddingleft: 0, paddingBottom: 0, paddingRight: 0,
                             width: 0, height: sectionHeight, centerX: nil, centerY: nil)
        
        tariffSortView.anchor(top: sortOrderView.bottomAnchor,
                              leading: leadingAnchor,
                              bottom: nil,
                              trailing: trailingAnchor,
                              paddingTop: 10, paddingleft: 0, paddingBottom: 0, paddingRight: 0,
                              width: 0, height: sectionHeight, centerX: nil, centerY: nil)
        
        subscriptionTypeFilterView.anchor(top: tariffSortView.bottomAnchor,
                                          leading: leadingAnchor,
                                          bottom: nil,
                                          trailing: trailingAnchor,
                                          paddingTop: 10, paddingleft: 0, paddingBottom: 0, paddingRight: 0,
                                          width: 0, height: sectionHeight, centerX: nil, centerY: nil)
        
        applyFilterButton.anchor(top: subscriptionTypeFilterView.bottomAnchor,
                                 leading: nil,
                                 bottom: nil,
                                 trailing: nil,
                                 paddingTop: 20, paddingleft: 0, paddingBottom: 0, paddingRight: 0,
                                 width: 250, height: 44, centerX: centerXAnchor, centerY: nil)
    }
}

extension SortFilterOptionsView: SortOrderViewDelegate {
    
    func didSelect(_ sortOrder: SortOrder) {
        sortFilterOptions.sortOrder = sortOrder
    }
}

extension SortFilterOptionsView: TariffSortViewDelegate {
    
    func didSelect(_ sortOption: TariffSortOption) {
        sortFilterOptions.tariffSortOption = sortOption
    }
}

extension SortFilterOptionsView: SubscriptionFilterViewDelegate {
    
    func didSelect(_ filterOption: SubscriptionFilterOption) {
        sortFilterOptions.subscriptionFilterOption = filterOption
    }
}
