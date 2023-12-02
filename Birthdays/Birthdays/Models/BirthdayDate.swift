//
//  File.swift
//  Birthdays
//
//  Created by Аброрбек on 29.11.2023.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class BirthdayDate: Comparable {
    static func == (lhs: BirthdayDate, rhs: BirthdayDate) -> Bool {
        return lhs.day == rhs.day && lhs.month == rhs.month
    }
    
    static func < (lhs: BirthdayDate, rhs: BirthdayDate) -> Bool {
        if lhs.month != rhs.month {
            return lhs.month < rhs.month
        } else {
            return lhs.day < rhs.day
        }
    }
    
    let day: Int
    let month: Int
    
    init(day: Int, month: Int) {
        self.day = day
        self.month = month
    }
}
