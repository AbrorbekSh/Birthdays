//
//  HomeViewModel.swift
//  Birthdays
//
//  Created by Аброрбек on 16.04.2024.
//

import SwiftUI
import Combine
import SwiftData
import UserNotifications

class HomeViewModel: ObservableObject {
    @Published var birthdays: [Birthday] = []
    @Published var notificationsEnabled: Bool = UserDefaults.standard.bool(forKey: "NotificationsEnabledInAppSettings")
    @Published var notificationsAreActive: Bool = UserDefaults.standard.bool(forKey: "NotificationsEnabledInAppSettings")
    @Published var showingNewDetailsView = false
    @Published var showingSearchView = false
    @Published var showingCalendarView = false
    @Published var showingSettingsView = false
    
    private var notificationTimer: Timer?
    
    let months = ["January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December"]
    
    let monthDictionary: [String: Int] = [
        "January": 1,
        "February": 2,
        "March": 3,
        "April": 4,
        "May": 5,
        "June": 6,
        "July": 7,
        "August": 8,
        "September": 9,
        "October": 10,
        "November": 11,
        "December": 12
    ]

    private var cancellables = Set<AnyCancellable>()
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadBirthdays()
        setupNotifications()
    }

    func loadBirthdays() {
        let descriptor = FetchDescriptor<Birthday>(predicate: nil)
        do {
            self.birthdays = try modelContext.fetch(descriptor)
        } catch {
            print("Some problems while fetching")
        }
    }
    
    func birthdaysForMonth(_ month: String) -> [Birthday] {
        return birthdays.filter { birthday in
            guard let date = birthday.date else { return false }
            return monthDictionary[month] == date.month
        }.sorted { birthday1, birthday2 in
            birthday1.date!.day < birthday2.date!.day
        }
    }

    func deleteBirthday(_ birthday: Birthday) {
        modelContext.delete(birthday)
        NotificationManager.shared.removeNotification(birthday: birthday)
    }

    @objc func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "This is a local notification sent every 5 seconds."
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to add notification request: \(error)")
            }
        }
    }

    func setupNotifications() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional:
                    self.notificationsAreActive = true
                default:
                    self.notificationsAreActive = false
                }
                UserDefaults.standard.set(self.notificationsAreActive, forKey: "NotificationsPermissionGranted")
            }
        }
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink(receiveValue: { _ in
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    DispatchQueue.main.async {
                        switch settings.authorizationStatus {
                        case .authorized, .provisional:
                            self.notificationsAreActive = true
                        default:
                            self.notificationsAreActive = false
                        }
                        UserDefaults.standard.set(self.notificationsAreActive, forKey: "NotificationsPermissionGranted")
                    }
                }
            })
            .store(in: &cancellables)
    }
}

