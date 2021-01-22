//
//  AligmentViewModel.swift
//  Runar
//
//  Created by Oleg Kanatov on 22.01.21.
//

import UIKit

class AlignmentViewModel {
    private let runeDescription: RuneDescription
    public var runeLayout: RuneLayout {
        runeDescription.layout
    }
    public init (runeDescription: RuneDescription) {
        self.runeDescription = runeDescription
    }
}
