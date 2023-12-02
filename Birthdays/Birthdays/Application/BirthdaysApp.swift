//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Аброрбек on 22.11.2023.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Birthday.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
