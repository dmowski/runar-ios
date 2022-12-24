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
        // TODO: No Internet
        //NetworkMonitor.shared.startMonitoring()
        
        if isFirstLaunch() {
            signIn()
        }
        
        //NetworkMonitor
        //        if NetworkMonitor.shared.isConnected {
        CoreDataManager.shared.applicationDocumentsDirectory()
        DataManager.shared.fetchData()
        //        } else {
        //            print("No internet")
        //        }

        if !UserDefaults.standard.bool(forKey: "subscribed") {
            SubscriptionManager.freeSubscription = true
        } else {
            SubscriptionManager.freeSubscription = false
        }

        MusicViewController.shared.initBackgroundMusic()
        if !UserDefaults.standard.bool(forKey: "is_off_music") {
            MusicViewController.shared.playBackgroundMusic()
        } else {
            MusicViewController.shared.stopBackgroundMusic()
        }

        return true
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    func isFirstLaunch() -> Bool {
        let isFirstLaunch = !LocalStorage.contains(key: .firstLaunch)
                
        if (isFirstLaunch) {
            LocalStorage.push(true, forKey: .firstLaunch)
        }
        
        return isFirstLaunch
    }
       
    func signIn() {
        let id = String.random(withLength: 32)
        let created = NSDate().timeIntervalSince1970
        let systemVersion = "IOS " + UIDevice.current.systemVersion
        RunarApi.createUser(with: id, date: created, os: systemVersion)
        print(id, created, systemVersion)
    }
}
