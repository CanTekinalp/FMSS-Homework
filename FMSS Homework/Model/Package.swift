//
//  Package.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

struct Packages: Decodable {
    let packages: [Package]
}

struct Package: Decodable {
    let name: String
    let description: String
    let subscriptionType: SubscriptionType
    let didUseBefore: Bool
    let benefits: [PackageBenefits]?
    let price: Double
    let tariff: PackageTariff
    let availableUntil: String
    
    var tariffData: Int {
        return tariff.data
    }

    var tariffSms: Int {
        return tariff.sms
    }
    
    var tariffTalk: Int {
        return tariff.talk
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case description = "desc"
        case subscriptionType
        case didUseBefore
        case benefits
        case price
        case tariff
        case availableUntil
    }
}
