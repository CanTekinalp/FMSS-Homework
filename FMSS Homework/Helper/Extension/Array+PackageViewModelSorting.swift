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
    
    private func filterBy(filterOption: SubscriptionFilterOption) -> Self? {
        if case let SubscriptionFilterOption.subscriptionType(subscriptionType) = filterOption {
            return filter { $0.package.subscriptionType == subscriptionType || $0.isFavourite }
        }
        return self
    }
    
    func sortBy(sortOption: TariffSortOption, sortOrder: SortOrder, filterOption: SubscriptionFilterOption = .all) -> Self? {
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
