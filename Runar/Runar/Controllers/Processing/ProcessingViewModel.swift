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
    public init (runeDescription: RuneDescription) {
        self.runeDescription = runeDescription
    }
}
