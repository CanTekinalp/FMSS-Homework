//
//  PackageBenefits.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 23.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

enum PackageBenefits: String, Decodable {
    case tvPlus = "TV+"
    case fizy = "Fizy"
    case bip = "BiP"
    case lifebox = "lifebox"
    case platinum = "Platinum"
    case dergilik = "Dergilik"
    
    private var imageName: String {
        switch self {
        case .tvPlus:
            return "tvplusIcon"
        case .fizy:
            return "fizyIcon"
        case .bip:
            return "bipIcon"
        case .lifebox:
            return "lifeboxIcon"
        case .platinum:
            return "platinumIcon"
        case .dergilik:
            return "dergilikIcon"
        }
    }
    
    var image: UIImage? {
        return UIImage(named: self.imageName)
    }
}
