//
//  HomeViewController.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import FittedSheets

final class HomeViewController: UIViewController {
    
    let sortFilterOptions = SortFilterOptions()
    lazy var packageListViewModel = PackageListViewModel(packages: loadJson() ?? nil)
    
    lazy var homePageView: HomePageView = {
        let homePage = HomePageView(viewModel: packageListViewModel, sortFilterOptions: sortFilterOptions)
        homePage.delegate = self
        return homePage
    }()
    
    lazy var sheetController = SheetViewController(controller: sortFilterOptionsViewController,
                                                   sizes: [.halfScreen])

    lazy var sortFilterOptionsViewController: SortFilterOptionsViewController = {
        let sortFilterOptionsViewController = SortFilterOptionsViewController(sortFilterOptions: sortFilterOptions)
        sortFilterOptionsViewController.delegate = self
        return sortFilterOptionsViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension HomeViewController {
    
    // MARK: Subview Setup
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(homePageView)
    }
    
    private func setupConstraints() {
        homePageView.fillSuperView()
    }
}

extension HomeViewController: HomePageViewDelegate {
    
    func didClickSortFilterOptionsButton() {
        self.present(sheetController, animated: false, completion: nil)
    }
}

extension HomeViewController: SortFilterOptionsViewControllerDelegate {
    
    func didClickApplyFilterButton() {
        sheetController.closeSheet { [weak self] in
            self?.homePageView.sort()
        }
    }
}
