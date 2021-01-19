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
        if UserDefaults.isFirstLaunch() {
            print("First launch")
        } else {
            print("Not first ")
        }
        return true
    }
}
    extension UserDefaults {
        // check for is first launch - only true on first invocation after app install, false on all further invocations
        // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
        static func isFirstLaunch() -> Bool {
            let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
            let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
            if (isFirstLaunch) {
                UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
                UserDefaults.standard.synchronize()
            }
            return isFirstLaunch
        }
    }




