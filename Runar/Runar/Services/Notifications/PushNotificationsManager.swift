//
//  AppDelegate+SetPushNotifications.swift
//  Runar
//
//  Created by Kyzu on 15.11.22.
//

import Foundation
import Firebase
import FirebaseMessaging

class PushNotificationsManager {
    static var shared = PushNotificationsManager()
    private init() {}
    
    func addNotifications(app: UIApplication, appDelegate: AppDelegate) {
        UNUserNotificationCenter.current().delegate = appDelegate
        Messaging.messaging().delegate = appDelegate
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_,_ in }
        )
        
        app.registerForRemoteNotifications()
    }
}
