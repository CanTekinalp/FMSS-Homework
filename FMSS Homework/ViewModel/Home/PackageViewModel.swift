//
//  PackageViewModel.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

enum SortPriority {
    case favourite
    case subscription(subscriptionType: SubscriptionType)
    
    var priority: Int {
        switch self {
        case .favourite:
            return 4
        case .subscription(let subscriptionType):
            return subscriptionType.priority
        }
    }
}

final class PackageViewModel {
    
    let package: Package
    var isFavourite: Bool = false
    
    var sortPriority: Int {
        let subscriptionTypePriority = package.subscriptionType.priority
        let isFavouritePriority = isFavourite ? SortPriority.favourite.priority : 0
        return isFavouritePriority + subscriptionTypePriority
    }
    
    var favouriteButtonTitle: String {
        return isFavourite ? "Favorilerden Çıkar" : "Favorilere Ekle"
    }
    
    var favouriteButtonColor: UIColor {
        return isFavourite ? .red : .cheese
    }
    
    var name: String {
        package.name
    }

    var description: String {
        package.description
    }
    
    var subscriptionTypeText: String {
        package.subscriptionType.title
    }
    
    var price: String {
        return String(format: "%.2f TL", package.price)
    }
    
    var benefits: [UIImage]? {
        return package.benefits?.compactMap { $0.image }
    }
    
    var talkText: String {
        return "\(package.tariff.talk) DK"
    }
    
    var dataText: String {
        return "\(package.tariff.data) MB"
    }
    
    var smsText: String {
        return "\(package.tariff.sms) SMS"
    }
    
    var didUseBeforeText: String {
        return package.didUseBefore ? "Daha önce kullanıldı" : ""
    }
    
    init(package: Package) {
        self.package = package
    }
}

extension PackageViewModel: Comparable {
    
    static func < (lhs: PackageViewModel, rhs: PackageViewModel) -> Bool {
        return lhs.sortPriority < rhs.sortPriority
    }
    
    static func > (lhs: PackageViewModel, rhs: PackageViewModel) -> Bool {
        return lhs.sortPriority > rhs.sortPriority
    }
    
    static func == (lhs: PackageViewModel, rhs: PackageViewModel) -> Bool {
        return lhs.sortPriority == rhs.sortPriority
    }
    
}
