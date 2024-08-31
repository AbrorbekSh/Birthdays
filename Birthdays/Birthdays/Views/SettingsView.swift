//
//  SettingsView.swift
//  Birthdays
//
//  Created by Abrorbek Shanazarov on 03.01.2024.
//

import SwiftUI
import Combine
import SwiftData

struct SettingsView: View {
    @Binding var notificationsEnabled: Bool
    @Binding var isActive: Bool

    //MARK: - SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var birthdays: [Birthday]

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            List {
                Section(header: Text("Notifications"), footer: Text(notificationAdvice)
                    .opacity(isActive ? 0 : 1)) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Allow Notifications")
                    }
                    .onChange(of: notificationsEnabled) {
                        switch notificationsEnabled {
                        case true:
                            NotificationManager.shared.scheduleNotifications(birthdays: birthdays)
                            UserDefaults.standard.set(true, forKey: "NotificationsEnabledInAppSettings")
                        case false:
                            NotificationManager.shared.removeAllNotifications()
                            UserDefaults.standard.set(false, forKey: "NotificationsEnabledInAppSettings")
                        }
                    }
                    .disabled(!isActive)
                }
            }
            Spacer()
            Section {
                Text("Made in Kazakhstan 🇰🇿")
                    .foregroundColor(.gray)
            }
    }

    private var notificationAdvice: String {
        "Notifications are disabled. Enable notifications for Birthdays in the system settings so that the app can send you notifications."
    }
}
//
//#Preview {
//    SettingsView(, isActive: <#Binding<Bool>#>)
//}
