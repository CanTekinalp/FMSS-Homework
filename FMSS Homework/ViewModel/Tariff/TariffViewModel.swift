//
//  TariffViewModel.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 23.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

final class TariffViewModel {
    
    let sortOption: TariffSortOption
    var isSelected: Bool = false
    
    init(sortOption: TariffSortOption) {
        self.sortOption = sortOption
    }
}


