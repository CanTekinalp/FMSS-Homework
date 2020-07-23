//
//  HomeViewController.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let homePageView = HomePageView(viewModel: PackageListViewModel(packages: loadJson() ?? nil))
    
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
