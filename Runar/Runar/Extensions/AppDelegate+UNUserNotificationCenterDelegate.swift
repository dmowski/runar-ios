//
//  File.swift
//  Runar
//
//  Created by Kyzu on 15.11.22.
//

import UIKit

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        print("Will Present")
        return [[.alert, .sound, .badge]]
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("Did Receive")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async -> UIBackgroundFetchResult {
        let gcmMessageIDKey = "gcm.Message_ID"
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print("Did Receive Remote Notification")
        return UIBackgroundFetchResult.newData
    }
}
