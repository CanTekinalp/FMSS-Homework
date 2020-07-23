//
//  TariffListViewModel.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 23.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

enum TariffSortOption: String {
    case price = "Fiyat"
    case data = "Data"
    case talk = "Dakika"
    case sms = "Sms"
}

final class TariffListViewModel {
    
    private let sortOptions: [TariffSortOption] = [.price, .data, .talk, .sms]
    private var tariffViewModels: [TariffViewModel]?
        
    var count: Int {
        tariffViewModels?.count ?? 0
    }
    
    init(_ selectedSortOption: TariffSortOption, _ selectedSortOrder: SortOrder) {
        tariffViewModels = sortOptions.map {
            let viewModel = TariffViewModel(sortOption: $0)
            if $0 == selectedSortOption {
                viewModel.isSelected = true
            }
            return viewModel
        }
    }
    
    func getViewModel(at index: Int) -> TariffViewModel? {
        if tariffViewModels?.indices.contains(index) == true {
            return tariffViewModels?[index]
        }
        return nil
    }
}
