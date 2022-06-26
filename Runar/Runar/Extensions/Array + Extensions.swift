//
//  Array + extension.swift
//  Runar
//
//  Created by Runar iOS team
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        0..<self.count ~= index ? self[index]: nil
    }
}
