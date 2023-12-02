//
//  Item.swift
//  Birthdays
//
//  Created by Аброрбек on 22.11.2023.


import Foundation
import SwiftData
import SwiftUI

@Model
final class Birthday {
    var photo: String?
    var name: String?
    var year: Int?
    var note: String?
    var group: String?
    var notificationEnabled: Bool?
    var date: BirthdayDate?
    
    init(
        photo: String? = nil,
        name: String,
        year: Int? = nil,
        note: String? = nil,
        group: String? = nil,
        notificationEnabled: Bool?,
        date: BirthdayDate?
    ) {
        self.photo = photo
        self.name = name
        self.year = year
        self.note = note
        self.group = group
        self.notificationEnabled = notificationEnabled
        self.date = date
    }
}

