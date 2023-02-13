//
//  UIColor+RunarTheme.swift
//  Runar
//
//  Created by Sasza Niehaj on 2/4/23.
//

import UIKit

extension UIColor {
    static var primaryDarkLeadColor: UIColor {
        guard let color = UIColor(named: "primaryDarkLeadColor") else {
            return UIColor(red: 0.129, green: 0.129, blue: 0.129)
        }
        return color
    }
    
    static var primaryDarkBackColor: UIColor {
        guard let color = UIColor(named: "primaryDarkBackColor") else {
            return UIColor(red: 0.078, green: 0.078, blue: 0.078)
        }
        return color
    }
    
    static var primaryDarkItemColor: UIColor {
        guard let color = UIColor(named: "primaryDarkItemColor") else {
            return UIColor(red: 0.161, green: 0.161, blue: 0.161)
        }
        return color
    }
    
    static var iconNeutralsGreyColor: UIColor {
        guard let color = UIColor(named: "iconNeutralsGreyColor") else {
            return UIColor(red: 0.569, green: 0.569, blue: 0.569)
        }
        return color
    }
    
    static var bottomNavigationIconsColor: UIColor {
        guard let color = UIColor(named: "bottomNavigationIconsColor") else {
            return UIColor(red: 0.431, green: 0.431, blue: 0.431)
        }
        return color
    }
    
    static var yellowPrimaryColor: UIColor {
        guard let color = UIColor(named: "yellowPrimaryColor") else {
            return UIColor(red: 0.825, green: 0.77, blue: 0.677)
        }
        return color
    }
    
    static var yellowSecondaryColor: UIColor {
        guard let color = UIColor(named: "yellowSecondaryColor") else {
            return UIColor(red: 0.937, green: 0.804, blue: 0.576)
        }
        return color
    }
    
    static var yellowTertiaryColor: UIColor {
        guard let color = UIColor(named: "yellowTertiaryColor") else {
            return UIColor(red: 1.0, green: 0.753, blue: 0.275)
        }
        return color
    }
    
    static var primaryBlackColor: UIColor {
        guard let color = UIColor(named: "primaryBlackColor") else {
            return UIColor(red: 0.165, green: 0.165, blue: 0.165)
        }
        return color
    }
    
    static var primaryWhiteColor: UIColor {
        guard let color = UIColor(named: "primaryWhiteColor") else {
            return UIColor(red: 0.973, green: 0.973, blue: 0.973)
        }
        return color
    }
    
    static var disabledTextColor: UIColor {
        guard let color = UIColor(named: "disabledTextColor") else {
            return UIColor(red: 0.675, green: 0.675, blue: 0.675)
        }
        return color
    }
    
    static var secondaryTextColor: UIColor {
        guard let color = UIColor(named: "secondaryTextColor") else {
            return UIColor(red: 0.431, green: 0.431, blue: 0.431)
        }
        return color
    }
    
    static var accentTextColor: UIColor {
        guard let color = UIColor(named: "accentTextColor") else {
            return UIColor(red: 0.824, green: 0.769, blue: 0.678)
        }
        return color
    }
}

/// Convenience initialization with default alpha value (1.0)
extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIColor {
    static let libraryTitleColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
}
