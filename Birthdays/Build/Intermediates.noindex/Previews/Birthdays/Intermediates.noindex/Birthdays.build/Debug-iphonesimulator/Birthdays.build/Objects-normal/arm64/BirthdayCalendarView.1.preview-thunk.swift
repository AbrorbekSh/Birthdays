@_private(sourceFile: "BirthdayCalendarView.swift") import Birthdays
import func SwiftUI.__designTimeBoolean
import func SwiftUI.__designTimeInteger
import protocol SwiftUI.PreviewProvider
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeFloat
import struct SwiftUI.EmptyView
import protocol SwiftUI.View
import SwiftData
import SwiftUI

extension BirthdayCalendarView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/BirthdayCalendarView.swift", line: 18)
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
            .navigationTitle(__designTimeString("#4438.[2].[4].property.[0].[0].arg[0].value.[0].modifier[1].arg[0].value", fallback: "Calendar"))
        }
    
#sourceLocation()
    }
}

import struct Birthdays.BirthdayCalendarView
#Preview {
    BirthdayCalendarView()
}



