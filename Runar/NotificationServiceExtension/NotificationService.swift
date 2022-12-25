//
//  NotificationService.swift
//  NotificationServiceExtension
//
//  Created by Artsiom Korenko on 25.12.22.
//

import UserNotifications
import UIKit

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    // In this metod I change server notification to modify notification and load picture
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        let customNotificationContent = UNMutableNotificationContent()
        
        guard let bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent),
              let urlString = bestAttemptContent.userInfo["banner_image"] as? String,
              let data = NSData(contentsOf: URL(string:urlString)!) as? Data else { return }
        
        let path = NSTemporaryDirectory() + "attachment"
        let createFile = FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
        
        do {
            let file = URL(fileURLWithPath: path)
            let attachment = try UNNotificationAttachment(identifier: "attachment", url: file,options:[UNNotificationAttachmentOptionsTypeHintKey : "public.jpeg"])
            customNotificationContent.attachments = [attachment]
        } catch {
            print(error)
        }
        
        customNotificationContent.categoryIdentifier.append("TEST_CATEGORY")
        customNotificationContent.title = bestAttemptContent.title
        customNotificationContent.body = bestAttemptContent.body
        
        contentHandler(customNotificationContent)
    }
    
    override func serviceExtensionTimeWillExpire() {
        guard let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent else { return }
        contentHandler(bestAttemptContent)
    }
}
