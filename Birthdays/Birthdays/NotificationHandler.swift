//
//  NotificationHandler.swift
//  Birthdays
//
//  Created by Abrorbek Shanazarov on 02.12.2023.
//

import Foundation
import UserNotifications

final class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()

    override private init() {}

    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                UserDefaults.standard.set(false, forKey: "NotificationsEnabledInAppSettings")
            } else if granted {
                UserDefaults.standard.set(true, forKey: "NotificationsPermissionGranted")
                UserDefaults.standard.set(true, forKey: "NotificationsEnabledInAppSettings")
            } else {
                UserDefaults.standard.set(false, forKey: "NotificationsPermissionGranted")
                UserDefaults.standard.set(false, forKey: "NotificationsEnabledInAppSettings")
            }
        }
    }

    func scheduleNotificationsWithBirthdays(birthdays: [Birthday]) {
        removeAllNotifications()
        for birthday in birthdays {
            scheduleNotificationWithBirthday(
                newBirthday: birthday,
                oldBirthday: nil
            )
        }
    }

    func scheduleNotificationWithBirthday(
        newBirthday: Birthday,
        oldBirthday: Birthday?
    ) {
        guard let id = newBirthday.id,
              let name = newBirthday.name,
              let day = newBirthday.date?.day,
              let month = newBirthday.date?.month
        else { return }

        if newBirthday.thatDayNotificationEnabled ?? false {
            let words = name.components(separatedBy: " ")
            let title = "\(words[0])'s Birthday Today 🎉"
            let body = "Don't miss out! A birthday is on its way. Prepare to make it memorable! 🎊🎁"

            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current

            dateComponents.month = month
            dateComponents.day = day
            dateComponents.hour = 19
            dateComponents.minute = 40

            scheduleNotification(
                name: name,
                title: title,
                body: body,
                dateComponents: dateComponents,
                id: id
            )
        }

        if newBirthday.dayBeforeNotificationEnabled  ?? false {
            let calendar = Calendar.current
            let date = Date().daysBefore(day: day, month: month, numberOfDaysBefore: 1)

            let words = name.components(separatedBy: " ")
            let title = "\(words[0])'s Birthday Tomorrow 🎉"
            let body = "Don't miss out! A birthday is on its way. Prepare to make it memorable! 🎊🎁"

            var dateComponents = calendar.dateComponents([.day, .month], from: date)
            dateComponents.hour = 10
            dateComponents.minute = 0

            scheduleNotification(
                name: name,
                title: title,
                body: body,
                dateComponents: dateComponents,
                id: id
            )
        }

        if newBirthday.weekBeforeNotificationEnabled ?? false {
            let calendar = Calendar.current
            let date = Date().daysBefore(day: day, month: month, numberOfDaysBefore: 7)

            let words = name.components(separatedBy: " ")
            let title = "\(words[0])'s Birthday in 7 days!"
            let body = "Don't miss out! A birthday is on its way. Prepare to make it memorable! 🎊🎁"

            var dateComponents = calendar.dateComponents([.day, .month], from: date)
            dateComponents.hour = 10
            dateComponents.minute = 0

            scheduleNotification(
                name: name,
                title: title,
                body: body,
                dateComponents: dateComponents,
                id: id
            )
        }

        removeNotificationWithBirthday(birthday: oldBirthday)
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge])
    }

    func removeNotificationWithBirthday(birthday: Birthday?) {
        guard let birthday = birthday else { return }

        guard let id = birthday.id,
              let day = birthday.date?.day,
              let month = birthday.date?.month
        else { return }

        var identifiers: [String] = []

        if birthday.thatDayNotificationEnabled ?? false {
            let identifier = generateIdentifier(fromID: id, month: month, day: day)
            identifiers.append(identifier)
        }

        if birthday.dayBeforeNotificationEnabled  ?? false {
            let calendar = Calendar.current
            let date = Date().daysBefore(day: day, month: month, numberOfDaysBefore: 1)

            var dateComponents = calendar.dateComponents([.day, .month], from: date)
            dateComponents.hour = 10
            dateComponents.minute = 0

            let identifier = generateIdentifier(
                fromID: id,
                month: dateComponents.month ?? 0,
                day: dateComponents.day ?? 0
            )
            identifiers.append(identifier)
        }

        if birthday.weekBeforeNotificationEnabled ?? false {
            let calendar = Calendar.current
            let date = Date().daysBefore(day: day, month: month, numberOfDaysBefore: 7)
            let dateComponents = calendar.dateComponents([.day, .month], from: date)

            let identifier = generateIdentifier(
                fromID: id,
                month: dateComponents.month ?? 0,
                day: dateComponents.day ?? 0
            )
            identifiers.append(identifier)
        }

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }

    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    //MARK: - Helper methods

    private func scheduleNotification(
        name: String,
        title: String,
        body: String,
        dateComponents: DateComponents,
        id: UUID
    ) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let identifier = generateIdentifier(
            fromID: id,
            month: dateComponents.month ?? 0,
            day: dateComponents.day ?? 0
        )

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully!")
            }
        }
    }

    private func generateIdentifier(
        fromID id: UUID,
        month: Int,
        day: Int
    ) -> String {
        let dateString = "\(month)-\(day)"
        let identifier = "\(id.uuidString)-\(dateString)"

        return identifier
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

