//
//  AppDelegate.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 3/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let initialViewController = HomeViewBuilder.build()
        let navigationController = UINavigationController(rootViewController: initialViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }


}

