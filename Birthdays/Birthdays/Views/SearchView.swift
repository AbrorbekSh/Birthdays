//
//  SearchView.swift
//  Birthdays
//
//  Created by Аброрбек on 01.12.2023.
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
                        let daysLeftMessage = daysLeft(date: birthday.date)
                        BirthdayCell(
                            nameLabelText: birthday.name ?? "",
                            dateLabelText: "\(birthday.date!.day).\(birthday.date!.month).\(year)",
                            daysCounterLabelText: daysLeftMessage
                        )
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
    
    func daysLeft(date: BirthdayDate?) -> String {
        let calendar = Calendar.current
        guard let day = date?.day,
              let month = date?.month,
              let date = date
        else { return "" }
        
        var nextYear = year
        if date < currentDate {
            nextYear += 1
        }
        
        var components1 = DateComponents()
        components1.year = year
        components1.month = currentDate.month
        components1.day = currentDate.day

        var components2 = DateComponents()
        components2.year = nextYear
        components2.month = month
        components2.day = day

        guard let startDate = calendar.date(from: components1),
              let endDate = calendar.date(from: components2) else {
            return ""
        }

        let difference = calendar.dateComponents([.day], from: startDate, to: endDate)

        guard let difference = difference.day else {
            return ""
        }
        
        switch difference {
        case 0:
            return "🥳Today"
        case 1:
            return "Tomorrow"
        default:
            return "In \(difference) Days"
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.orange)
                .padding()
            
            TextField("Search", text: $text)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .background(Color.gray.opacity(0.3))
        .cornerRadius(8)
    }
}


#Preview {
    SearchView()
}
