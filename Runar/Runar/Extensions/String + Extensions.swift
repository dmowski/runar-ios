//
//  String.swift
//  Runar
//
//  Created by George Stupakov on 14/06/2022.
//

import Foundation

extension String {
    static func random(withLength length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
