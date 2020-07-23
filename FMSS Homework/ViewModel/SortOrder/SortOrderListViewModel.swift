//
//  SortOrderListViewModel.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 23.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

enum SortOrder: String {
    case ascending = "Artan"
    case descending = "Azalan"
}

final class SortOrderListViewModel {
    
    private static let sortOrders: [SortOrder] = [.descending, .ascending]
    private var sortOrderViewModel: [SortOrderViewModel]?
        
    var count: Int {
        sortOrderViewModel?.count ?? 0
    }
    
    init(_ selectedSortOrder: SortOrder) {
        sortOrderViewModel = SortOrderListViewModel.sortOrders.map {
            let viewModel = SortOrderViewModel(sortOrder: $0)
            if $0 == selectedSortOrder {
                viewModel.isSelected = true
            }
            return viewModel
        }
    }
    
    func getViewModel(at index: Int) -> SortOrderViewModel? {
        if sortOrderViewModel?.indices.contains(index) == true {
            return sortOrderViewModel?[index]
        }
        return nil
    }
}
