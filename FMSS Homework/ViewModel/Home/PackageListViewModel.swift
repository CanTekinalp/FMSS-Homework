//
//  PackageListViewModel.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import Foundation

final class PackageListViewModel {
    
    private let packages: [Package]?
    private(set) var packageViewModels: [PackageViewModel]?
    
    var viewModelCount: Int {
        return packageViewModels?.count ?? 0
    }
    
    init(packages: [Package]?) {
        self.packages = packages
        initPackageViewModels()
    }
    
    private func initPackageViewModels() {
        guard let packages = packages else { return }
        let favouritePackages = UserDefaults.standard.getFavouritePackages(packages: packages)
        packageViewModels = packages.map {
            let viewModel = PackageViewModel(package: $0)
            favouritePackages.forEach {
                if $0.name == viewModel.name {
                    viewModel.isFavourite = true
                }
            }
            return viewModel
        }
    }
}
