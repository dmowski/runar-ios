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
        
        guard let notificationContent = (request.content.mutableCopy() as? UNMutableNotificationContent),
              let imageUrl = notificationContent.userInfo["banner_image"] as? String,
              let imageData = NSData(contentsOf: URL(string:imageUrl)!) as? Data else { return }
        
        let pathToSafeDirectory = NSTemporaryDirectory() + "attachment"
        _ = FileManager.default.createFile(atPath: pathToSafeDirectory, contents: imageData, attributes: nil)
        
        do {
            let fileWithBannerImage = URL(fileURLWithPath: pathToSafeDirectory)
            let attachment = try UNNotificationAttachment(identifier: "attachment", url: fileWithBannerImage,options:[UNNotificationAttachmentOptionsTypeHintKey : "public.jpeg"])
            customNotificationContent.attachments = [attachment]
        } catch {
            print(error)
        }
        
        customNotificationContent.categoryIdentifier.append("OPEN_PUSH_CATEGORY")
        customNotificationContent.title = notificationContent.title
        customNotificationContent.body = notificationContent.body
        
        contentHandler(customNotificationContent)
    }
    
    override func serviceExtensionTimeWillExpire() {
        guard let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent else { return }
        contentHandler(bestAttemptContent)
    }
}
