//
//  BirthdayCell.swift
//  Birthdays
//
//  Created by Abrorbek Shanazarov on 22.11.2023.
//

import SwiftUI

struct BirthdayCell: View {
    //MARK: - Date
    private let currentDate: BirthdayDate = {
        let date = Calendar.current.dateComponents([.day, .month], from: Date())
        return BirthdayDate(day: date.day ?? 0, month: date.month ?? 0)
    }()

    private let year: Int = {
        let year = Calendar.current.component(.year, from: Date())
        return year
    }()

    private var nameLabelText: String?
    private var dateLabelText: String?
    private var daysCounterLabelText: String?

    init(name: String?, date: BirthdayDate?) {
        nameLabelText = name
        dateLabelText = createDateString(date: date)
        daysCounterLabelText = daysLeft(date: date)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(nameLabelText ?? "")
                    .font(.headline)
                Text(dateLabelText ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(daysCounterLabelText ?? "")
                .font(.body)
        }
//        onAppear {
//            dateLabelText = createDateString()
//            nameLabelText = birthday.name
//            daysCounterLabelText = daysLeft(date: birthday.date)
//        }
    }

    private func createDateString(date: BirthdayDate?) -> String? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = date?.day
        dateComponents.month = date?.month
        dateComponents.year = year

        if let date = calendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }

    private func daysLeft(date: BirthdayDate?) -> String {
        let calendar = Calendar.current
        guard let day = date?.day,
              let month = date?.month,
              let date = date
        else { return "" }

        var nextYear = year
        if date < currentDate {
            nextYear += 1
        }

        var components1 = DateComponents()
        components1.year = year
        components1.month = currentDate.month
        components1.day = currentDate.day

        var components2 = DateComponents()
        components2.year = nextYear
        components2.month = month
        components2.day = day

        guard let startDate = calendar.date(from: components1),
              let endDate = calendar.date(from: components2) else {
            return ""
        }

        let difference = calendar.dateComponents([.day], from: startDate, to: endDate)

        guard let difference = difference.day else {
            return ""
        }

        switch difference {
        case 0:
            return "🥳Today"
        case 1:
            return "Tomorrow"
        default:
            return "In \(difference) Days"
        }
    }
}
