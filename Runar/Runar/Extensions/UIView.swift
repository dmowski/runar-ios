//
//  UIView.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

extension UIView {
    
    public var viewWidth: CGFloat {
        return self.frame.size.width
    }
    
    public var viewHeight: CGFloat {
        return self.frame.size.height
    }

    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func addTapGesture(tapNumber: Int = 1, _ closure: (() -> Void)?) {
        guard let closure = closure else { return }

        let tap = BindableGestureRecognizer(action: closure)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)

        isUserInteractionEnabled = true
    }
}
