//
//  BirthdayCalendarCell.swift
//  Birthdays
//
//  Created by Alisher Zinullayev on 20.12.2023.
//

import SwiftUI

struct BirthdayCalendarCell: View {
    var nameLabelText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(nameLabelText)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
    }
}
