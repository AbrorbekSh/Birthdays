//
//  BirthdayCalendarListView.swift
//  Birthdays
//
//  Created by Abrorbek Shanazarov on 20.12.2023.
//

import SwiftUI

struct BirthdayCalendarListView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject var birthdaysViewModel: BirthdaysViewModel
    @Binding var dateSelected: DateComponents?
    
    var body: some View {
        NavigationStack {
            Group {
                if let selectedComponents = dateSelected {
                    let foundBirthdays = birthdaysViewModel.birthdays.filter {
                        guard let birthdayDate = $0.date else { return false }
                        return birthdayDate.day == selectedComponents.day && birthdayDate.month == selectedComponents.month
                    }
                    List {
                        ForEach(foundBirthdays) { birthday in
                            BirthdayCalendarCell(nameLabelText: birthday.name ?? "default name")
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        context.delete(birthday)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}


struct BirthdayCalendarListView_Previews: PreviewProvider {
    static var previews: some View {
        let now = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: now)

        let viewModel = BirthdaysViewModel(birthdays: [])

        BirthdayCalendarListView(dateSelected: .constant(dateComponents))
            .environmentObject(viewModel)
    }
}
