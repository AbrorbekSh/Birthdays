//
//  BirthdayCell.swift
//  Birthdays
//
//  Created by Аброрбек on 22.11.2023.
//

import SwiftUI

struct BirthdayCell: View {
    var nameLabelText: String
    var dateLabelText: String
    var daysCounterLabelText: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(nameLabelText)
                    .font(.headline)
                Text(dateLabelText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(daysCounterLabelText)
                .font(.body)
        }
    }
}
