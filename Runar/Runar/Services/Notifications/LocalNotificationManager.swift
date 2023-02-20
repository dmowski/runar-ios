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

private enum TimeOfSendingLocalNotifications: Int {
    case weekday = 2 // Monday
    // Temp: 11 -> 19
    case hour = 19   // 11:00
}

protocol LocalNotificationInterface {
    /// Checking the resolution of notifications and add notification
    func addNotification()

    /// Remove all notification
    func removeAllNotifications()
}

final class LocalNotificationManager: NSObject, LocalNotificationInterface {

    private let notificationCenter = UNUserNotificationCenter.current()

    /// If the user logs into the app on the day of the notification call before the time of the call, the notification on that day will be deleted
    private func checkTheDayAndTime() {
        let dateComponents = Calendar.current.dateComponents([.weekday, .hour, .weekOfMonth], from: Date())
        let weekdaySetPoint = TimeOfSendingLocalNotifications.weekday.rawValue
        let hourSetPoint = TimeOfSendingLocalNotifications.hour.rawValue

        guard let weekday = dateComponents.weekday,
              let hour = dateComponents.hour,
              let week = dateComponents.weekOfMonth else { return }

        if weekday == weekdaySetPoint && hour < hourSetPoint {
            var identifier: String = .notificationGeneralIdentifier
            identifier += "_Week_\(week)"
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        }
    }

    /// Request permission from the user to receive notifications
    private func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            guard let self = self else { return }

            if granted {
                self.addRequest()
            } else {
                print("Local Notification: User has declined notifications")
            }
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
        dateComponents.weekday = TimeOfSendingLocalNotifications.weekday.rawValue
        dateComponents.hour = TimeOfSendingLocalNotifications.hour.rawValue
        // Temp: added minute
        dateComponents.minute = 5

        for week in 1...5 {
            var identifier: String = .notificationGeneralIdentifier
            identifier += "_Week_\(week)"
            dateComponents.weekOfMonth = week

            // Creating the trigger as a repeating event
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // Creating the notification request
            let request = UNNotificationRequest(identifier: identifier,
                                                content: content,
                                                trigger: trigger)

            notificationCenter.add(request) { error in
                if let error = error {
                    print("Local Notification: Error \(error.localizedDescription)")
                }
            }
        }

        // Temp: commented
//        checkTheDayAndTime()
    }

    func addNotification() {
        notificationCenter.getNotificationSettings { [weak self] settings in
            guard let self = self else { return }

            if settings.authorizationStatus == .authorized {
                self.addRequest()
            } else {
                self.requestAuthorization()
            }
        }
    }

    func removeAllNotifications() {
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
