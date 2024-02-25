//
//  SearchView.swift
//  Birthdays
//
//  Created by Abrorbek Shanazarov on 01.12.2023.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    //MARK: - Date
    private let currentDate: BirthdayDate = {
        let date = Calendar.current.dateComponents([.day, .month], from: Date())
        return BirthdayDate(day: date.day ?? 0, month: date.month ?? 0)
    }()
    
    private let year: Int = {
        let year = Calendar.current.component(.year, from: Date())
        return year
    }()
    
    //MARK: - SwiftData
    
    @Environment(\.modelContext) var modelContext
    @Query var birthdays: [Birthday]
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var searchText = ""
    
    
    var filteredBirthdays: [Birthday] {
        if searchText.isEmpty {
            return birthdays
        } else {
            return birthdays.filter {
                $0.name!.lowercased().contains(
                    searchText.lowercased()
                )
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredBirthdays.sorted(by: { $0.name! < $1.name! })) { birthday in
                BirthdayCell(name: birthday.name, date: birthday.date)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            modelContext.delete(birthday)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
            .modifier(DismissingKeyboard())
            .navigationBarItems(trailing:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
                    .foregroundColor(.orange)
            }
            )
            .navigationBarTitle("Search", displayMode: .inline)
        }
        .searchable(text: $searchText)
    }
}


#Preview {
    SearchView()
}
