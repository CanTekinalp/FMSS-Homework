//
//  SortOrderViewModel.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 23.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

final class SortOrderViewModel {
    
    let sortOrder: SortOrder
    var isSelected: Bool = false
    
    var title: String {
        return sortOrder.rawValue
    }
    
    init(sortOrder: SortOrder) {
        self.sortOrder = sortOrder
    }
}
