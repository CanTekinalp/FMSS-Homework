//
//  SortFilterOptionsViewModel.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 24.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import Foundation

final class SortFilterOptions {
    var sortOrder: SortOrder = .descending
    var tariffSortOption: TariffSortOption = .price
    var subscriptionFilterOption: SubscriptionFilterOption = .all
}
