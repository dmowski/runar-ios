//
//  LocalNotificationManager.swift
//  Runar
//
//  Created by Alexey Poletaev on 09.02.2023.
//

import UserNotifications

private extension String {
    static let notificationGeneralContentTitle = L10n.Notifications.General.title
    static let notificationGeneralContentBody = L10n.Notifications.General.body
    static let notificationGeneralIdentifier = "General Local Notification"
}

struct RunarNotificationInfo {
    let weekday: Int // Sunday(1), Monday(2)...
    let hour: Int // 11
}

protocol LocalNotificationInterface {
    /// Checking the resolution of notifications and add notification
    func addNotification()

    /// Remove all notification
    func removeAllNotifications()
}

final class LocalNotificationManager: NSObject, LocalNotificationInterface {
    
    // MARK: - private properties
    private let notificationCenter = UNUserNotificationCenter.current()
    private let maxMonthWeeksNumber = 5
    
    // MARK: - internal properties
    let weeklyNotification = RunarNotificationInfo(weekday: 2, hour: 11)
    
    // MARK: - private methods
    /// If the user logs into the app on the day of the notification call before the time of the call, the notification on that day will be deleted
    private func checkTheDayAndTime() {
        let dateComponents = Calendar.current.dateComponents([.weekday, .hour, .weekOfMonth, .minute], from: Date())
        let weekdaySetPoint = weeklyNotification.weekday
        let hourSetPoint = weeklyNotification.hour

        guard let weekday = dateComponents.weekday,
              let hour = dateComponents.hour,
              let week = dateComponents.weekOfMonth
        else { return }

        if weekday == weekdaySetPoint && hour < hourSetPoint {
            var identifier: String = .notificationGeneralIdentifier
            identifier += "_Week_\(week)"
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        }
    }
    
    /// Request permission from the user to receive notifications
    private func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] isGranted, error in
            guard let strongSelf = self else { return }
            
            guard error == nil else {
                print(error?.localizedDescription ?? "Authorization denied")
                return
            }
            
            guard isGranted else {
                print("Local Notification: User has declined notifications")
                return
            }
            strongSelf.addRequest()
        }
    }
    
    /// The function of generating sending notifications
    private func addRequest() {
        // Notification Content
        let content = UNMutableNotificationContent()
        content.title = .notificationGeneralContentTitle
        content.body = .notificationGeneralContentBody
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        // Configuration the recurring date
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = weeklyNotification.weekday
        dateComponents.hour = weeklyNotification.hour
        
        let weeksRange = 1...maxMonthWeeksNumber
        
        weeksRange.forEach {
            var identifier: String = .notificationGeneralIdentifier
            identifier += "_Week_\($0)"
            dateComponents.weekOfMonth = $0
            
            // Creating the trigger as a repeating event
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            // Creating the notification request
            let request = UNNotificationRequest(identifier: identifier,
                                                content: content,
                                                trigger: trigger)
            
            notificationCenter.add(request) { [weak self] error in
                guard let _ = self, let error = error else {
                    return
                }
                print("Local Notification error: \(error.localizedDescription)")
            }
        }
        
        checkTheDayAndTime()
    }
    
    // MARK: - internal methods
    func addNotification() {
        notificationCenter.getNotificationSettings { [weak self] settings in
            guard let strongSelf = self else { return }
            
            guard settings.authorizationStatus == .authorized else {
                strongSelf.requestAuthorization()
                return
            }
            strongSelf.addRequest()
        }
    }
    
    func removeAllNotifications() {
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
