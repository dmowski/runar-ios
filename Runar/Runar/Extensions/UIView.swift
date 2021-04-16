//
//  UIView.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit.UIView

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
