//
//  NotificationView.swift
//  Birthdays
//
//  Created by Alisher Zinullayev on 05.12.2023.
//

import SwiftUI

struct NotificationView: View {
    @State var isNotificationEnabled: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle(isOn: $isNotificationEnabled) {
                        Text("Notifications")
                    }
                } footer: {
                    Text(notificationAdvice)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Settings")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
    }
    
    private var notificationAdvice: String {
        if isNotificationEnabled {
            return "Notifications are disabled. Enable notifications for Birthdays in the system settings so that the app can send you notifications."
        } else {
            return "Notifications are enabled. Disable notifications for Birthdays in the system settings so that the app can not send you notifications."
        }
    }
}

#Preview {
    NotificationView()
}
