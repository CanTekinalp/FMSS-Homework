//
//  SubscriptionListViewModel.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 23.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

final class SubscriptionTypeListViewModel {
    
    private static let filterOption: [SubscriptionFilterOption] = [.all,
                                        .subscriptionType(subscriptionType: SubscriptionType.weekly),
                                       .subscriptionType(subscriptionType: SubscriptionType.monthly),
                                       .subscriptionType(subscriptionType: SubscriptionType.yearly)]
    
    var subscriptionViewModels: [SubscriptionTypeViewModel]?
    
    var count: Int {
        subscriptionViewModels?.count ?? 0
    }
    
    init(_ selectedFilterOption: SubscriptionFilterOption) {
        subscriptionViewModels = SubscriptionTypeListViewModel.filterOption.map {
            let viewModel = SubscriptionTypeViewModel(filterOption: $0)
            if $0 == selectedFilterOption {
                viewModel.isSelected = true
            }
            return viewModel
        }
    }
    
    func getViewModel(at index: Int) -> SubscriptionTypeViewModel? {
        if subscriptionViewModels?.indices.contains(index) == true {
            return subscriptionViewModels?[index]
        }
        return nil
    }
}
