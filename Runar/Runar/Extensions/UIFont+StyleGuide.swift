//
//  UIFont+StyleGuide.swift
//  Runar
//
//  Created by Sasza Niehaj on 2/4/23.
//

import UIKit

extension UIFont {
    static func systemLight(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .light)
    }
    
    static func systemMedium(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .medium)
    }
    
    static func systemRegular(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .regular)
    }
    
    static func amaticBold(size: CGFloat) -> UIFont {
        return UIFont(name: "AmaticSC-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
}
