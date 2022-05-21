//
//  ProcessingViewModel.swift
//  Runar
//
//  Created by Юлия Лопатина on 5.02.21.
//

import Foundation

public class ProcessingViewModel {
    public let runeDescription: RuneDescription
    public var name: String {
        runeDescription.name
    }
    public let closeTransition: () -> Void
    public init (runeDescription: RuneDescription, closeTransition: @escaping () -> Void) {
        self.runeDescription = runeDescription
        self.closeTransition = closeTransition
    }
}
