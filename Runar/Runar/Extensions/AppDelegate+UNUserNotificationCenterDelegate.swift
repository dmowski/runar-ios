//
//  AppDelegate+UNUserNotificationCenterDelegate.swift
//  Runar
//
//  Created by Artsiom Korenko on 25.12.22.
//

import Foundation
import UIKit

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        [[.alert, .sound, .badge]]
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async { }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async -> UIBackgroundFetchResult {
        let gcmMessageIDKey = "gcm.Message_ID"
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        return UIBackgroundFetchResult.newData
    }
}
