//
//  CustomDatePicker.swift
//  Birthdays
//
//  Created by Аброрбек on 03.12.2023.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDate: Date

    var body: some View {
        HStack {
            WheelPicker(selection: $selectedDate, dateComponent: .day)
            WheelPicker(selection: $selectedDate, dateComponent: .month)
            WheelPicker(selection: $selectedDate, dateComponent: .year)
        }
    }
}

struct WheelPicker: View {
    @Binding var selection: Date
    var dateComponent: Calendar.Component

    var body: some View {
        let calendar = Calendar.current
        let range = calendar.range(of: dateComponent, in: .era, for: selection)!
        let count = range.count

        return Picker(selection: getDateBinding(), label: Text("")) {
            ForEach(0..<count, id: \.self) { index in
                Text("\(calendar.component(dateComponent, from: selection) + index)")
                    .tag(calendar.date(byAdding: dateComponent, value: index, to: startOfDay())!)
            }
        }
        .frame(width: 100)
        .clipped()
        .pickerStyle(WheelPickerStyle())
    }

    private func getDateBinding() -> Binding<Date> {
        let index = Calendar.current.component(dateComponent, from: selection)
        let newDate = Calendar.current.date(byAdding: dateComponent, value: -index, to: startOfDay())!
        return Binding<Date>(
            get: { self.selection },
            set: { _ in self.selection = Calendar.current.date(byAdding: self.dateComponent, value: 0, to: newDate)! }
        )
    }

    private func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: selection)
    }
}

// Usage:
struct ContentViews: View {
    @State var selectedDate = Date()

    var body: some View {
        VStack {
            CustomDatePicker(selectedDate: $selectedDate)
                .padding()
            
            Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                .padding()
        }
    }

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

#Preview {
    ContentViews()
}
