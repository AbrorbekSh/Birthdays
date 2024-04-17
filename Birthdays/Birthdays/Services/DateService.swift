//
//  DateService.swift
//  Birthdays
//
//  Created by Аброрбек on 16.04.2024.
//

import Foundation

class DateService {
    let calendar: Calendar

    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }

    func daysInMonth(month: Int, year: Int) -> [Int] {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month

        guard let date = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in: .month, for: date) else {
            return []
        }

        return Array(range.lowerBound..<range.upperBound)
    }

    func isLeapYear(year: Int) -> Bool {
        let dateComponents = DateComponents(year: year)
        guard let date = calendar.date(from: dateComponents) else {
            return false
        }
        let range = calendar.range(of: .day, in: .year, for: date)!
        return range.count > 365
    }
}
