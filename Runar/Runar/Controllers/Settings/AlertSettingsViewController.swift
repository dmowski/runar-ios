//
//  AlertSettingsViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 15.04.21.
//

import UIKit

extension String {
    static let alertTitle = L10n.Tabbar.settings
    static let alertMessage = L10n.Tabbar.openSettings
    static let alertYes = L10n.Tabbar.allow
    static let alertCancel = L10n.Tabbar.cancel
}

class AlertSettingsViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        let alertController = UIAlertController (title: .alertTitle, message: .alertMessage, preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: .alertYes, style: .default) { (_) -> Void in

           guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
               return
           }

           if UIApplication.shared.canOpenURL(settingsUrl) {
               UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                   print("Settings opened: \(success)") // Prints true
               })
           }
            self.dismiss(animated: true, completion: nil)
       }
       alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: .alertCancel, style: .default) { (_) -> Void in
            self.dismiss(animated: true, completion: nil)}
       alertController.addAction(cancelAction)

       present(alertController, animated: true, completion: nil)
   }
}
