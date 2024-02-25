//
//  BirthdayCalendarView.swift
//  Birthdays
//
//  Created by Abrorbek Shanazarov on 19.12.2023.
//

import SwiftUI
import SwiftData

struct BirthdayCalendarView: View {
    @Query var birthdays: [Birthday]
    @State private var dateSelected: DateComponents?
    @State private var displayBirthdays = false
    @StateObject var birthdaysViewModel = BirthdaysViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CalendarView(
                    interval: DateInterval(
                        start: .distantPast,
                        end: .distantFuture
                    ),
                    viewModel: birthdaysViewModel,
                    dateSelected: $dateSelected,
                    displayBirthdays: $displayBirthdays
                )
                .onAppear {
                    birthdaysViewModel.birthdays = birthdays
                }
            }
            .sheet(isPresented: $displayBirthdays, content: {
                BirthdayCalendarListView(dateSelected: $dateSelected)
                    .environmentObject(birthdaysViewModel)
                    .presentationDetents([.medium, .large])
            })
            .navigationTitle("Calendar")
        }
    }
}

#Preview {
    BirthdayCalendarView()
}
