//
//  SubscriptionViewModel.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 23.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

enum SubscriptionFilterOption {
    case all
    case subscriptionType(subscriptionType: SubscriptionType)
}

extension SubscriptionFilterOption: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.all, .all):
            return true
        case (SubscriptionFilterOption.subscriptionType(let a), SubscriptionFilterOption.subscriptionType(let b)):
            return a == b
        default:
            return false
        }
    }

}

final class SubscriptionTypeViewModel {
    
    let filterOption: SubscriptionFilterOption
    var isSelected: Bool = false
    
    var title: String {
        switch filterOption {
        case .all:
            return "Tümü"
        case .subscriptionType(let subscriptionType):
            return subscriptionType.title
        }
    }
    
    init(filterOption: SubscriptionFilterOption) {
        self.filterOption = filterOption
    }
}
