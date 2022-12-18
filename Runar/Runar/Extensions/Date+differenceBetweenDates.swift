//
//  Date+differenceBetweenDates.swift
//  Runar
//
//  Created by Kyzu on 26.11.22.
//

import Foundation

extension Date {
    static func differenceInHours(from: Date, to: Date) -> Int {
    var currentDate: Calendar = Calendar.current
        currentDate.timeZone = .current
        print(currentDate.dateComponents([.day], from: to, to: from).day ?? 0)
        return currentDate.dateComponents([.day], from: to, to: from).day ?? 0
    }
}
