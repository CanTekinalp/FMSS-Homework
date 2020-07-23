//
//  AppDelegate.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 21.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

func loadJson() -> [Package]? {
    if let url = Bundle.main.url(forResource: "packageList", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let packages = try JSONDecoder().decode(Packages.self, from: data)
            return packages.packages
        } catch {
            print("Error: \(error)")
        }
    }
    return nil
}

