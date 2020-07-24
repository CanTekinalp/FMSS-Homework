//
//  SortFilterOptionsViewModel.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 24.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import Foundation

final class SortFilterOptions {
    var sortOrder: SortOrder = .ascending
    var tariffSortOption: TariffSortOption = .data
    var subscriptionFilterOption: SubscriptionFilterOption = .all
}
