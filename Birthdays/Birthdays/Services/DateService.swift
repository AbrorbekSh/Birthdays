//
//  DateService.swift
//  Birthdays
//
//  Created by Аброрбек on 16.04.2024.
//

import Foundation

final class DateService {
    static func daysInMonth(month: Int, year: Int) -> [Int] {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        
        let calendar: Calendar = .current

        guard let date = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in: .month, for: date) else {
            return []
        }

        return Array(range.lowerBound..<range.upperBound)
    }

    static func isLeapYear(year: Int) -> Bool {
        let dateComponents = DateComponents(year: year)
        let calendar: Calendar = .current
        
        guard let date = calendar.date(from: dateComponents) else {
            return false
        }
        let range = calendar.range(of: .day, in: .year, for: date)!
        return range.count > 365
    }
}
