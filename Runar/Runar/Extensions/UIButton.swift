//
//  UIButton.swift
//  Runar
//
//  Created by George Stupakov on 25/05/2022.
//

import UIKit

extension UIButton {

    func setTitle(title: String, color: UIColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)){
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineHeightMultiple = 0.79
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [
                                                        NSMutableAttributedString.Key.paragraphStyle: paragraphStyle,
                                                        NSMutableAttributedString.Key.font: FontFamily.AmaticSC.bold.font(size: 24),
                                                        NSMutableAttributedString.Key.foregroundColor: color])
        
        self.setAttributedTitle(attributedText, for: .normal)
    }
}
