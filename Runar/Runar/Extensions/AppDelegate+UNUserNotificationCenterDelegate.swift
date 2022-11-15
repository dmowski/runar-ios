//
//  File.swift
//  Runar
//
//  Created by Kyzu on 15.11.22.
//

import UIKit

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
        _ = notification.request.content.userInfo
        return [[.alert, .sound]]
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
        _ = response.notification.request.content.userInfo
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
    -> UIBackgroundFetchResult {
        
        let gcmMessageIDKey = "gcm.Message_ID"
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        return UIBackgroundFetchResult.newData
    }
}
