//
//  SubscriptionManager.swift
//  Runar
//
//  Created by George Stupakov on 26/09/2022.
//

import UIKit

public class SubscriptionManager {
    public static var freeSubscription: Bool = true

    public static func presentMonetizationVC(vc: UIViewController) {
        let monetizationVC = MonetizationVC()
        monetizationVC.modalPresentationStyle = .fullScreen
        vc.present(monetizationVC, animated: true, completion: nil)
    }
}
