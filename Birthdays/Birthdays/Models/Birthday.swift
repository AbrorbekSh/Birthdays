//
//  Item.swift
//  Birthdays
//
//  Created by Аброрбек on 22.11.2023.


import Foundation
import SwiftData
import SwiftUI

@Model
final class Birthday: ObservableObject, Identifiable {
    var id: UUID?
    var name: String?
    var year: String?
    var note: String?
    var thatDayNotificationEnabled: Bool?
    var dayBeforeNotificationEnabled: Bool?
    var weekBeforeNotificationEnabled: Bool?
    var date: BirthdayDate?
    
    init(
        id: UUID? = UUID(),
        name: String,
        year: String? = nil,
        note: String? = nil,
        thatDayNotificationEnabled: Bool?,
        dayBeforeNotificationEnabled: Bool?,
        weekBeforeNotificationEnabled: Bool?,
        date: BirthdayDate?
    ) {
        self.name = name
        self.year = year
        self.note = note
        self.thatDayNotificationEnabled = thatDayNotificationEnabled
        self.dayBeforeNotificationEnabled = dayBeforeNotificationEnabled
        self.weekBeforeNotificationEnabled = weekBeforeNotificationEnabled
        self.date = date

        if id == nil {
            self.id = UUID()
        } else {
            self.id = id
        }
    }
}

