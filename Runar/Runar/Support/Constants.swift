//
//  Constants.swift
//  Runar
//
//  Created by Юлия Лопатина on 19.01.21.
//

import UIKit

enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceType {
    static let iPhoneSE = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0
    static let isIPhone678 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667.0
    static let isIphone78Plus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 736.0
}
