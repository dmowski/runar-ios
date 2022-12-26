//
//  PushNotificationsManager.swift
//  Runar
//
//  Created by Artsiom Korenko on 25.12.22.
//

import Foundation
import Firebase
import FirebaseMessaging

class PushNotificationsManager {
    static var shared = PushNotificationsManager()

    func addNotifications(app: UIApplication, appDelegate: AppDelegate) {
        UNUserNotificationCenter.current().delegate = appDelegate
        Messaging.messaging().delegate = appDelegate

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })

        let openButton = UNNotificationAction(identifier: "Open", title: L10n.open, options: .foreground)
        let closeButton = UNNotificationAction(identifier: "Close", title: L10n.close, options: .destructive)
        let openPushCategory = UNNotificationCategory(identifier: "OPEN_PUSH_CATEGORY", actions: [openButton, closeButton], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([openPushCategory])

        app.registerForRemoteNotifications()
    }
}
