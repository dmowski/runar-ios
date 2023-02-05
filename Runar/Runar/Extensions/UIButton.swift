//
//  UIButton.swift
//  Runar
//
//  Created by George Stupakov on 25/05/2022.
//

import UIKit

extension UIButton {

    func setTitle(title: String, color: UIColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)) {
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineHeightMultiple = 0.79
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [
                                                        .paragraphStyle: paragraphStyle,
                                                        .font: UIFont.amaticBold(size: 24),
                                                        .foregroundColor: color])
        
        self.setAttributedTitle(attributedText, for: .normal)
    }
}
