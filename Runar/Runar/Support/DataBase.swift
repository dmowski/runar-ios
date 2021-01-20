//
//  DataBase.swift
//  Runar
//
//  Created by Юлия Лопатина on 3.01.21.
//

import Foundation

struct DataBase {
    
    let namesDataSourse = ["Руна дня","Расклад из 2 рун","Норны","Краткий прогноз","Молот Тора","Крест","Крест стихий","Кельтский крест"]
    
   static let alDescription = [
    "Руна дня" : L10n.runesOfTheDay,
    "Расклад из 2 рун" : L10n.layoutOfTwoRunes,
    "Норны" : L10n.norns,
    "Молот Тора" : L10n.thorsHammer,
    "Краткий прогноз": L10n.briefForecast,
    "Крест" : L10n.cross,
    "Крест стихий" : L10n.crossOfTheElements,
    "Кельтский крест" : L10n.celticCross
    ]
}
