//
//  HomePageView.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

protocol HomePageViewDelegate: NSObjectProtocol {
    func didClickSortFilterOptionsButton()
}

final class HomePageView: UIView {
    
    weak var delegate: HomePageViewDelegate?

    private var packageListViewModel: PackageListViewModel?
    private var sortFilterOptions: SortFilterOptions

    private var resultArray: [PackageViewModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var searchText: String = ""
    
    lazy var searchView: SearchBarView = {
        let searchView = SearchBarView()
        searchView.delegate = self
        return searchView
    }()
    
    lazy var sortFilterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "filterIcon"), for: .normal)
        button.addTarget(self, action: #selector(handleSortFilterButton), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
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
    
    init(viewModel: PackageListViewModel, sortFilterOptions: SortFilterOptions) {
        self.packageListViewModel = viewModel
        self.sortFilterOptions = sortFilterOptions
        super.init(frame: .zero)
        setup()
        sort()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleSortFilterButton() {
        delegate?.didClickSortFilterOptionsButton()
    }
    
    func sort() {
        resultArray = packageListViewModel?.packageViewModels?.sortBy(sortFilterOptions: sortFilterOptions)
    }
}

extension HomePageView {
    
    // MARK: Subview Setup
    private func setup() {
        setupSubviews()
        setupConstraints()
        setupTableView()
        backgroundColor = .doctor
    }
    
    private func setupSubviews() {
        addSubview(searchView)
        addSubview(sortFilterButton)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        searchView.anchor(top: safeAreaLayoutGuide.topAnchor,
                             leading: leadingAnchor,
                             bottom: nil,
                             trailing: trailingAnchor,
                             paddingTop: 15, paddingleft: 0, paddingBottom: 0, paddingRight: 50,
                             width: 0, height: 50, centerX: nil, centerY: nil)
        
        sortFilterButton.anchor(top: nil,
                                leading: nil,
                                bottom: nil,
                                trailing: trailingAnchor,
                                paddingTop: 15, paddingleft: 0, paddingBottom: 0, paddingRight: 15,
                                width: 30, height: 30, centerX: nil, centerY: searchView.centerYAnchor)
        
        tableView.anchor(top: searchView.bottomAnchor,
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

extension HomePageView: SearchBarViewDelegate {
    
    func searchView(textDidChange searchText: String) {
        self.searchText = searchText
        if searchText.isEmpty == false && searchText.count > 2 {
            resultArray = packageListViewModel?.packageViewModels?.sortBy(sortFilterOptions: sortFilterOptions,
                                                                          searchText: searchText)
        }
    }
    
    func searchTextFieldCleared() {
        searchText = ""
        resultArray = packageListViewModel?.packageViewModels?.sortBy(sortFilterOptions: sortFilterOptions,
                                                                      searchText: searchText)
    }
}

extension HomePageView: PackageTableViewCellDelegate {
    
    func didClickFavouriteButton() {
        resultArray = packageListViewModel?.packageViewModels?.sortBy(sortFilterOptions: sortFilterOptions,
                                                                      searchText: searchText)
    }
}
