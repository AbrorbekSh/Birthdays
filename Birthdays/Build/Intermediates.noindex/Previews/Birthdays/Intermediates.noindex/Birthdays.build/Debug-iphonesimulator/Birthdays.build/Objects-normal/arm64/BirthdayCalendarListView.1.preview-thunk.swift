@_private(sourceFile: "BirthdayCalendarListView.swift") import Birthdays
import func SwiftUI.__designTimeBoolean
import func SwiftUI.__designTimeInteger
import protocol SwiftUI.PreviewProvider
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeFloat
import struct SwiftUI.EmptyView
import protocol SwiftUI.View
import SwiftUI

extension BirthdayCalendarListView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/BirthdayCalendarListView.swift", line: 44)
        let now = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: now)

        let viewModel = BirthdaysViewModel(birthdays: [])

        BirthdayCalendarListView(dateSelected: .constant(dateComponents))
            .environmentObject(viewModel)
    
#sourceLocation()
    }
}

extension BirthdayCalendarListView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/BirthdayCalendarListView.swift", line: 16)
        NavigationStack {
            Group {
                if let selectedComponents = dateSelected {
                    let foundBirthdays = birthdaysViewModel.birthdays.filter {
                        guard let birthdayDate = $0.date else { return false }
                        return birthdayDate.day == selectedComponents.day && birthdayDate.month == selectedComponents.month
                    }
                    List {
                        ForEach(foundBirthdays) { birthday in
                            BirthdayCalendarCell(nameLabelText: birthday.name ?? __designTimeString("#3985.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].[0].[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0]", fallback: "default name"))
                                .swipeActions(edge: .trailing, allowsFullSwipe: __designTimeBoolean("#3985.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].[0].[1].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[1].value", fallback: false)) {
                                    Button(role: .destructive) {
                                        context.delete(birthday)
                                    } label: {
                                        Label(__designTimeString("#3985.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].[0].[1].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[2].value.[0].arg[2].value.[0].arg[0].value", fallback: "Delete"), systemImage: __designTimeString("#3985.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].[0].[1].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[2].value.[0].arg[2].value.[0].arg[1].value", fallback: "trash"))
                                    }
                                }
                        }
                    }
                }
            }
        }
    
#sourceLocation()
    }
}

import struct Birthdays.BirthdayCalendarListView
import struct Birthdays.BirthdayCalendarListView_Previews

