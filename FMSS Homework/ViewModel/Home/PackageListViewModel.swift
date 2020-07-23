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

extension Array where Element == PackageViewModel {
    
    private func sortByPrice(sortOrder: SortOrder) -> [PackageViewModel]? {
        return sorted(by: { first, second in
            if first == second {
                return sortOrder == .descending ? first.package.price > second.package.price :
                    first.package.price < second.package.price
            }
            return first > second
        })
    }
    
    private func sortByTariffData(sortOrder: SortOrder) -> [PackageViewModel]? {
        return sorted(by: { first, second in
            if first == second {
                return sortOrder == .descending ? first.package.tariffData > second.package.tariffData : first.package.tariffData < second.package.tariffData
            }
            return first > second
        })
    }
    
    private func sortByTariffSms(sortOrder: SortOrder) -> [PackageViewModel]? {
        return sorted(by: { first, second in
            if first == second {
                return sortOrder == .descending ? first.package.tariffSms > second.package.tariffSms : first.package.tariffSms < second.package.tariffSms
            }
            return first > second
        })
    }
    
    private func sortByTariffTalk(sortOrder: SortOrder) -> [PackageViewModel]? {
        return sorted(by: { first, second in
            if first == second {
                return sortOrder == .descending ? first.package.tariffTalk > second.package.tariffTalk : first.package.tariffTalk < second.package.tariffTalk
            }
            return first > second
        })
    }
    
    private func filterBy(filterOption: SubscriptionFilterOption) -> [PackageViewModel]? {
        if case let SubscriptionFilterOption.subscriptionType(subscriptionType) = filterOption {
            return filter { $0.package.subscriptionType == subscriptionType || $0.isFavourite }
        }
        return self
    }
    
    func sortBy(sortOption: TariffSortOption, sortOrder: SortOrder, filterOption: SubscriptionFilterOption = .all) -> [PackageViewModel]? {
        let filtered = filterBy(filterOption: filterOption)

        switch sortOption {
        case .price:
            return filtered?.sortByPrice(sortOrder: sortOrder)
        case .data:
            return filtered?.sortByTariffData(sortOrder: sortOrder)
        case .talk:
            return filtered?.sortByTariffTalk(sortOrder: sortOrder)
        case .sms:
            return filtered?.sortByTariffSms(sortOrder: sortOrder)
        }
    }
    

}
