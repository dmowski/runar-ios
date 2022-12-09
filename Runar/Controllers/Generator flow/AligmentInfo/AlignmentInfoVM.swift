//
//  AlignmentInfoVM.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import Foundation

public class AlignmentInfoVM {
    public let runeDescription: RuneDescription
    public var name: String {
        runeDescription.name
    }
    public init (runeDescription: RuneDescription) {
        self.runeDescription = runeDescription
    }
}
