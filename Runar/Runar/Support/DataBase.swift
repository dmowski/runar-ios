//
//  DataBase.swift
//  Runar
//
//  Created by Юлия Лопатина on 3.01.21.
//

import Foundation

struct DataBase {
    
    static let runes = [
        RuneDescription(id: UUID().uuidString, name: L10n.Rune.DayRune.name, layout: .dayRune, description: L10n.Rune.DayRune.description),
        RuneDescription(id: UUID().uuidString, name: L10n.Rune.TwoRunes.name, layout: .twoRunes, description: L10n.Rune.TwoRunes.description),
        RuneDescription(id: UUID().uuidString, name: L10n.Rune.Norns.name, layout: .norns, description: L10n.Rune.Norns.description),
        RuneDescription(id: UUID().uuidString, name: L10n.Rune.ShortPrediction.name, layout: .shortPrediction, description: L10n.Rune.ShortPrediction.description),
        RuneDescription(id: UUID().uuidString, name: L10n.Rune.ThorsHummer.name, layout: .thorsHummer, description: L10n.Rune.ThorsHummer.description),
        RuneDescription(id: UUID().uuidString, name: L10n.Rune.Cross.name, layout: .cross, description: L10n.Rune.Cross.description),
        RuneDescription(id: UUID().uuidString, name: L10n.Rune.ElementsCross.name, layout: .elementsCross, description: L10n.Rune.ElementsCross.description),
        RuneDescription(id: UUID().uuidString, name: L10n.Rune.KeltsCross.name, layout: .keltsCross, description: L10n.Rune.KeltsCross.description)
    ]
}

