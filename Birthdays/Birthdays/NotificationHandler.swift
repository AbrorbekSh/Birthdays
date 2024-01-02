//
//  NotificationHandler.swift
//  Birthdays
//
//  Created by Аброрбек on 02.12.2023.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()

    override private init() {}

    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if granted {
                UserDefaults.standard.set(true, forKey: "NotificationsPermissionGranted")
                print("Notification permission granted!")
            } else {
                UserDefaults.standard.set(false, forKey: "NotificationsPermissionGranted")
                print("Notification permission denied.")
            }
        }
    }

    func scheduleNotificationWithDate(
        day: Int,
        month: Int,
        thatDayEnabled: Bool,
        dayBeforeEnabled: Bool,
        weekBeforeEnabled: Bool,
        name: String
    ) {
        if thatDayEnabled {
            let words = name.components(separatedBy: " ")
            let title = "\(words[0])'s Birthday Today 🎉"
            let body = "Don't miss out! A birthday is on its way. Prepare to make it memorable! 🎊🎁"

            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current

            dateComponents.month = day
            dateComponents.day = month
            dateComponents.hour = 10
            dateComponents.minute = 0

            scheduleNotification(
                title: title,
                body: body,
                dateComponents: dateComponents
            )
        }

        if dayBeforeEnabled {
            let calendar = Calendar.current
            let date = Date().daysBefore(day: day, month: month, numberOfDaysBefore: 1)

            let words = name.components(separatedBy: " ")
            let title = "\(words[0])'s Birthday Tomorrow 🎉"
            let body = "Don't miss out! A birthday is on its way. Prepare to make it memorable! 🎊🎁"

            var dateComponents = calendar.dateComponents([.day, .month], from: date)
            dateComponents.hour = 10
            dateComponents.minute = 0

            scheduleNotification(
                title: title,
                body: body,
                dateComponents: dateComponents
            )

        }

        if weekBeforeEnabled {
            let calendar = Calendar.current
            let date = Date().daysBefore(day: day, month: month, numberOfDaysBefore: 7)

            let words = name.components(separatedBy: " ")
            let title = "\(words[0])'s Birthday in 7 days!"
            let body = "Don't miss out! A birthday is on its way. Prepare to make it memorable! 🎊🎁"

            var dateComponents = calendar.dateComponents([.day, .month], from: date)
            dateComponents.hour = 10
            dateComponents.minute = 0

            scheduleNotification(
                title: title,
                body: body,
                dateComponents: dateComponents
            )

        }
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge])
    }

    //MARK: - Helper methods

    private func scheduleNotification(
        title: String,
        body: String,
        dateComponents: DateComponents
    ) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully!")
            }
        }
    }
}

extension Date {
    fileprivate func daysBefore(day: Int, month: Int, numberOfDaysBefore: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month

        if let currentDate = calendar.date(from: dateComponents),
           let dayBeforeDate = calendar.date(
            byAdding: .day,
            value: -numberOfDaysBefore,
            to: currentDate
           ) {
            return dayBeforeDate
        } else {
            return self
        }
    }
}

