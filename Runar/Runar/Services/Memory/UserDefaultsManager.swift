//
//  DateForNotificationManager.swift
//  Runar
//
//  Created by Kyzu on 25.11.22.
//

import Foundation

open class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    let lastDateKey = "lastVisitDate"
    
    private init() {}
    
    func saveDate() {
        UserDefaults.standard.set(Date().localDate(), forKey: lastDateKey)
    }
    
    func getDate() -> Date {
        let date = UserDefaults.standard.object(forKey: lastDateKey) as? Date ?? Date().localDate()
        return date
    }

}
