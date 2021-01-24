//
//  AligmentViewModel.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import Foundation

public class AlignmentViewModel {
    public let runeDescription: RuneDescription
    public var runeLayout: RuneLayout {
        runeDescription.layout
    }
    public var name: String {
        runeDescription.name
    }
    public init (runeDescription: RuneDescription) {
        self.runeDescription = runeDescription
    }
}




