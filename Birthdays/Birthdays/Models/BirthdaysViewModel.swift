//
//  BirthdaysViewModel.swift
//  Birthdays
//
//  Created by Alisher Zinullayev on 19.12.2023.
//

import Foundation

class BirthdaysViewModel: ObservableObject {
    @Published var birthdays: [Birthday]

    init(birthdays: [Birthday] = []) {
        self.birthdays = birthdays
    }
}
