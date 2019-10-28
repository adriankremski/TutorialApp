//
//  AppDelegate.swift
//  AutoLayoutPlayground
//
//  Created by Adrian Kremski on 28/10/2019.
//  Copyright © 2019 Adrian Kremski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipingController = SwipingController(collectionViewLayout: layout)
        
        window?.rootViewController = swipingController
    
        return true
    }
}

