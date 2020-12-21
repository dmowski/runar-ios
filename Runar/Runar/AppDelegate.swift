//
//  AppDelegate.swift
//  Runar
//
//  Created by Юлия Лопатина on 16.12.20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "Initial") as! UITabBarController
                        window?.rootViewController = newViewcontroller
        window?.makeKeyAndVisible()
        return true
    }




}

