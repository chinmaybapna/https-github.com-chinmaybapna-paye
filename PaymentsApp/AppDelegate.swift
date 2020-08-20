//
//  AppDelegate.swift
//  PaymentsApp
//
//  Created by Chinmay Bapna on 23/07/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

        if let isLoggedIn = UserDefaults.standard.string(forKey: "isLoggedIn"), let role = UserDefaults.standard.string(forKey: "role") {
            print(isLoggedIn)
            print(role)
            if isLoggedIn == "yes" && role == "customer" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                let initialViewController = storyboard.instantiateViewController(withIdentifier: "face_IdVC_customer")

                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }

            if isLoggedIn == "yes" && role == "merchant" {
                let storyboard = UIStoryboard(name: "MerchantFlow", bundle: nil)

                let initialViewController = storyboard.instantiateViewController(withIdentifier: "face_IdVC_merchant")

                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }
        }
        
        return true
    }
}

