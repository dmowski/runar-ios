//
//  NotificationViewController.swift
//  NotificationContentExtension
//
//  Created by Kyzu on 17.11.22.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        //MARK: - Notification Actions
        
       // self.label?.text = notification.request.content.body
    }

}
