//
//  NotificationViewController.swift
//  NotificationContentExtension
//
//  Created by Artsiom Korenko on 25.12.22.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        
        let bannerAttachment = notification.request.content.attachments.first {
            $0.identifier == "attachment"
        }
        
        guard let attachment = bannerAttachment,
              attachment.url.startAccessingSecurityScopedResource(),
              let imageData = try? Data(contentsOf: attachment.url),
              let image = UIImage(data: imageData) else { return }
        
        preferredContentSize = preferredContentSize(forImageWithSize: image.size)
        imageView.image = image
    }
    
    private func preferredContentSize(forImageWithSize imageSize: CGSize) -> CGSize {
        guard imageSize.width > view.frame.width else { return imageSize }
        let multiplier = imageSize.width / view.frame.width
        return CGSize(width: view.frame.width, height: imageSize.height / multiplier)
    }
}

