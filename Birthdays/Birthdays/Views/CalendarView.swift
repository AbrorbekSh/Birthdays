//
//  CalendarView.swift
//  Birthdays
//
//  Created by Аброрбек on 23.11.2023.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Calendar")
                .font(.title)
                .padding(.horizontal, 20)

            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .environment(\.locale, Locale(identifier: "ru"))
                .labelsHidden()
                .padding(.horizontal, 20)
            
            List {
                    Section(header: Text("Today")) {
                        BirthdayCell(nameLabelText: "Abrobek", dateLabelText: "27.06.2024", daysCounterLabelText: "216 days")
                        BirthdayCell(nameLabelText: "Nurdaulet", dateLabelText: "20.12.2024", daysCounterLabelText: "30 days")
                        BirthdayCell(nameLabelText: "Nurdaulet", dateLabelText: "20.12.2024", daysCounterLabelText: "30 days")
                        BirthdayCell(nameLabelText: "Nurdaulet", dateLabelText: "20.12.2024", daysCounterLabelText: "30 days")

                    }
            }
            Spacer()
        }
    }
}

#Preview {
    CalendarView()
}
