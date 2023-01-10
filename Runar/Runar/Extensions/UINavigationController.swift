//
//  UINavigationController.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

extension UINavigationController {
    
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.tag = 1
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
    
    func deletStatusBarView() {
        view.subviews.forEach {
            if $0.tag == 1 {
                $0.removeFromSuperview()
            }
        }
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = false) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}
