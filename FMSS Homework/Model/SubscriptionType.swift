//
//  SubscriptionType.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 23.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

enum SubscriptionType: String, Decodable {
    case weekly
    case monthly
    case yearly
    
    var title: String {
        switch self {
        case .weekly:
            return "Haftalık"
        case .monthly:
            return "Aylık"
        case .yearly:
            return "Yıllık"
        }
    }
    
    var priority: Int {
        switch self {
        case .weekly:
            return 1
        case .monthly:
            return 2
        case .yearly:
            return 3
        }
    }
}
