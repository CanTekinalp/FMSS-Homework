//
//  HomePageView.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

final class HomePageView: UIView {
    
    private var packageListViewModel: PackageListViewModel?
    
    private var resultArray: [PackageViewModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var selectedSortOrder: SortOrder = .descending
    private var selectedSortOption: TariffSortOption = .price
    private var selectedFilterOption: SubscriptionFilterOption = .all
    private var searchText: String = ""
    
    lazy var searchView: SearchView = {
        let searchView = SearchView()
        searchView.delegate = self
        return searchView
    }()
    
    lazy var sortOrderView: SortOrderView = {
        let sortOrderView = SortOrderView()
        sortOrderView.sortOrderListViewModel = SortOrderListViewModel(selectedSortOrder)
        sortOrderView.delegate = self
        sortOrderView.backgroundColor = .doctor
        return sortOrderView
    }()
    
    lazy var tariffSortView: TariffSortView = {
        let tariffSortView = TariffSortView()
        tariffSortView.tariffListViewModel = TariffListViewModel(selectedSortOption, selectedSortOrder)
        tariffSortView.delegate = self
        tariffSortView.backgroundColor = .doctor
        return tariffSortView
    }()
    
    lazy var subscriptionTypeFilterView: SubscriptionFilterView = {
        let subscriptionTypeFilterView = SubscriptionFilterView()
        subscriptionTypeFilterView.subscriptionTypeListViewModel = SubscriptionTypeListViewModel(selectedFilterOption)
        subscriptionTypeFilterView.delegate = self
        subscriptionTypeFilterView.backgroundColor = .doctor
        return subscriptionTypeFilterView
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 450
        return tableView
    }()
    
    init(viewModel: PackageListViewModel) {
        super.init(frame: .zero)
        self.packageListViewModel = viewModel
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subscriptionTypeFilterView.drawShadow(shadowData: ShadowData(cornerRadius: 0, shadowColor: .black, alpha: 0.2, offset: CGSize(width: 0, height: 5)))
    }
}

extension HomePageView {
    
    // MARK: Subview Setup
    private func setup() {
        resultArray = packageListViewModel?.packageViewModels?.sortBy(sortOption: selectedSortOption, sortOrder: selectedSortOrder)
        
        setupSubviews()
        setupConstraints()
        setupTableView()
        backgroundColor = .doctor
    }
    
    private func setupSubviews() {
        addSubview(searchView)
        addSubview(sortOrderView)
        addSubview(tariffSortView)
        addSubview(subscriptionTypeFilterView)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        searchView.anchor(top: safeAreaLayoutGuide.topAnchor,
                             leading: leadingAnchor,
                             bottom: nil,
                             trailing: trailingAnchor,
                             paddingTop: 15, paddingleft: 0, paddingBottom: 0, paddingRight: 0,
                             width: 0, height: 50, centerX: nil, centerY: nil)
        
        let sectionHeight: CGFloat = 80

        sortOrderView.anchor(top: searchView.bottomAnchor,
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
        
        tableView.anchor(top: subscriptionTypeFilterView.bottomAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         paddingTop: 10, paddingleft: 0, paddingBottom: 0, paddingRight: 0,
                         width: 0, height: 0, centerX: nil, centerY: nil)
    }
    
    private func setupTableView() {
        tableView.register(PackageTableViewCell.self, forCellReuseIdentifier: PackageTableViewCell.cellIdentifier)
    }
}

extension HomePageView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.cellIdentifier, for: indexPath) as! PackageTableViewCell
        cell.packageViewModel = resultArray?[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension HomePageView: SearchViewDelegate {
    
    func searchView(textDidChange searchText: String) {
        self.searchText = searchText
        if searchText.isEmpty == false && searchText.count > 2 {
            resultArray = packageListViewModel?.packageViewModels?.sortBy(sortOption: selectedSortOption,
                                                                          sortOrder: selectedSortOrder,
                                                                          subscriptionFilterOption: selectedFilterOption,
                                                                          searchText: searchText)
        }
    }
    
    func searchTextFieldCleared() {
        searchText = ""
        resultArray = packageListViewModel?.packageViewModels?.sortBy(sortOption: selectedSortOption,
                                                                      sortOrder: selectedSortOrder,
                                                                      subscriptionFilterOption: selectedFilterOption,
                                                                      searchText: searchText)
    }
}

extension HomePageView: SortOrderViewDelegate {
    
    func didSelect(_ sortOrder: SortOrder) {
        selectedSortOrder = sortOrder
        resultArray = packageListViewModel?.packageViewModels?.sortBy(sortOption: selectedSortOption,
                                                                      sortOrder: selectedSortOrder,
                                                                      subscriptionFilterOption: selectedFilterOption,
                                                                      searchText: searchText)
    }
}

extension HomePageView: TariffSortViewDelegate {
    
    func didSelect(_ sortOption: TariffSortOption) {
        selectedSortOption = sortOption
        resultArray = packageListViewModel?.packageViewModels?.sortBy(sortOption: selectedSortOption,
                                                                      sortOrder: selectedSortOrder,
                                                                      subscriptionFilterOption: selectedFilterOption,
                                                                      searchText: searchText)
    }
}

extension HomePageView: SubscriptionFilterViewDelegate {
    
    func didSelect(_ filterOption: SubscriptionFilterOption) {
        selectedFilterOption = filterOption
        resultArray = packageListViewModel?.packageViewModels?.sortBy(sortOption: selectedSortOption,
                                                                      sortOrder: selectedSortOrder,
                                                                      subscriptionFilterOption: filterOption,
                                                                      searchText: searchText)
    }
}

extension HomePageView: PackageTableViewCellDelegate {
    
    func didClickFavouriteButton() {
        resultArray = packageListViewModel?.packageViewModels?.sortBy(sortOption: selectedSortOption,
                                                                      sortOrder: selectedSortOrder,
                                                                      subscriptionFilterOption: selectedFilterOption,
                                                                      searchText: searchText)
    }
}
