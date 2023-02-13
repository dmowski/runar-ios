//
//  UINavigationBar+Configure .swift
//  Runar
//
//  Created by Andrei on 11.02.2023.
//

import UIKit

extension UINavigationBar {
    func configureTitle() -> Void {
        backgroundColor = .navBarBackground
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.79
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 30 : 36
        titleTextAttributes = [.font: UIFont.amaticBold(size: fontSize),
                               .foregroundColor: UIColor.libraryTitleColor,
                               .paragraphStyle: paragraphStyle]
        isTranslucent = false
        barTintColor = .navBarBackground
        tintColor = .libraryTitleColor
    }
}
