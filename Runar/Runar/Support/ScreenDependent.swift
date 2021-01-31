//
//  ScreenDependent2.swift
//  Runar
//
//  Created by Oleg Kanatov on 26.01.21.
//

import UIKit



private extension CGFloat {
    static let canonicalHeight: CGFloat = 896
    static let canonicalWidth: CGFloat = 414
}

protocol ScreenDependent {
    func widthDependent(layoutWidth: CGFloat, clamped bounds: Range<CGFloat>) -> CGFloat
    func heightDependent(layoutHeight: CGFloat, clamped bounds: Range<CGFloat>) -> CGFloat
}

extension ScreenDependent where Self: Numeric {
    private var asCGFloat: CGFloat {
        let value: CGFloat
        
        if let amount = self as? Float {
            value = CGFloat(amount)
        } else if let amount = self as? Double {
            value = CGFloat(amount)
        } else if let amount = self as? CGFloat {
            value = CGFloat(amount)
        } else if let amount = self as? Int {
            value = CGFloat(amount)
        } else if let amount = self as? UInt {
            value = CGFloat(amount)
        } else {
            value = 0.0
        }
        
        return value
    }
    
    private func widthMultiplier(layoutWidth: CGFloat) -> CGFloat {
        UIScreen.main.bounds.width / layoutWidth
    }

    private func heightMultiplier(layoutHeight: CGFloat) -> CGFloat {
        UIScreen.main.bounds.height / layoutHeight
    }
    
    func widthDependent(layoutWidth: CGFloat = .canonicalWidth, clamped bounds: Range<CGFloat> = 0..<CGFloat.greatestFiniteMagnitude) -> CGFloat {
        asCGFloat.multiplied(by: widthMultiplier(layoutWidth: layoutWidth)).clamped(to: bounds)
    }
    func heightDependent(layoutHeight: CGFloat = .canonicalHeight, clamped bounds: Range<CGFloat> = 0..<CGFloat.greatestFiniteMagnitude) -> CGFloat {
        asCGFloat.multiplied(by: heightMultiplier(layoutHeight: layoutHeight)).clamped(to: bounds)
    }
}

extension Float: ScreenDependent { }
extension Double: ScreenDependent { }
extension Int: ScreenDependent { }
extension CGFloat: ScreenDependent { }
extension UInt: ScreenDependent { }

private extension CGFloat {
    func precisedTo(digits power: Int) -> CGFloat {
        let delimiter = 10 ^^ power
        return (self * delimiter).rounded(.toNearestOrEven) / delimiter
    }

    func multiplied(by multiplier: CGFloat, precision: Int = 2) -> CGFloat {
        (self * multiplier).precisedTo(digits: precision)
    }
    
    func clamped(to range: Range<CGFloat>) -> CGFloat {
        Swift.max(Swift.min(range.upperBound, self), range.lowerBound)
    }
}

infix operator ^^
private func ^^ (radix: CGFloat, power: Int) -> CGFloat {
    pow(radix, CGFloat(power))
}

