//
//  Int+Extension.swift
//  Runar
//
//  Created by Artsiom Korenko on 11.01.23.
//

import Foundation
import UIKit

extension Int {
    
    func getLuckyLevelString() -> String {
        switch self {
        case 0...20:
            return L10n.LuckLevel.from0To20
        case 21...40:
            return L10n.LuckLevel.from21To40
        case 41...69:
            return L10n.LuckLevel.from41To69
        case 70...100:
            return L10n.LuckLevel.from70To100
        default:
            return String()
        }
    }
}
