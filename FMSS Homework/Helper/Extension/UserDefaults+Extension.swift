//
//  UserDefaults+Extension.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 22.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func saveFavouritePackage(package: Package) {
        UserDefaults.standard.set(true, forKey: package.name)
    }

    func removeFromFavouritePackages(package: Package) {
        let key = package.name
        if let _ = UserDefaults.standard.object(forKey: key) as? Bool {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    func getFavouritePackages(packages: [Package]) -> [Package] {
        var favPacks: [Package] = []
        packages.forEach {
            let key = $0.name
            if let _ = UserDefaults.standard.object(forKey: key) as? Bool {
                favPacks.append($0)
            }
        }
        return favPacks
    }
}
