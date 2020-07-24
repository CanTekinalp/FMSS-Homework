//
//  Array+PackageViewModelSorting.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 24.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

extension Array where Element == PackageViewModel {
    
    private func sortByPrice(sortOrder: SortOrder) -> Self? {
        return sorted(by: { first, second in
            if first == second {
                return sortOrder == .descending ? first.package.price > second.package.price :
                    first.package.price < second.package.price
            }
            return first > second
        })
    }
    
    private func sortByTariffData(sortOrder: SortOrder) -> Self? {
        return sorted(by: { first, second in
            if first == second {
                return sortOrder == .descending ? first.package.tariffData > second.package.tariffData : first.package.tariffData < second.package.tariffData
            }
            return first > second
        })
    }
    
    private func sortByTariffSms(sortOrder: SortOrder) -> Self? {
        return sorted(by: { first, second in
            if first == second {
                return sortOrder == .descending ? first.package.tariffSms > second.package.tariffSms : first.package.tariffSms < second.package.tariffSms
            }
            return first > second
        })
    }
    
    private func sortByTariffTalk(sortOrder: SortOrder) -> Self? {
        return sorted(by: { first, second in
            if first == second {
                return sortOrder == .descending ? first.package.tariffTalk > second.package.tariffTalk : first.package.tariffTalk < second.package.tariffTalk
            }
            return first > second
        })
    }
    
    private func filterBy(subscriptionFilterOption: SubscriptionFilterOption) -> Self? {
        if case let SubscriptionFilterOption.subscriptionType(subscriptionType) = subscriptionFilterOption {
            return filter { $0.package.subscriptionType == subscriptionType || $0.isFavourite }
        }
        return self
    }
    
    private func filterBy(searchText: String) -> Self? {
        if searchText.isEmpty || searchText.count < 3 {
            return self
        }
        return filter { $0.package.name.uppercased().contains(searchText.uppercased()) }
    }

    func sortBy(sortFilterOptions: SortFilterOptions, searchText: String = "") -> Self?
    {
        let filteredBySubscription = filterBy(subscriptionFilterOption: sortFilterOptions.subscriptionFilterOption)
        let filteredBySearchText = filteredBySubscription?.filterBy(searchText: searchText)

        let sortOrder = sortFilterOptions.sortOrder
        switch sortFilterOptions.tariffSortOption {
        case .price:
            return filteredBySearchText?.sortByPrice(sortOrder: sortOrder)
        case .data:
            return filteredBySearchText?.sortByTariffData(sortOrder: sortOrder)
        case .talk:
            return filteredBySearchText?.sortByTariffTalk(sortOrder: sortOrder)
        case .sms:
            return filteredBySearchText?.sortByTariffSms(sortOrder: sortOrder)
        }
    }
}
