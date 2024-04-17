//
//  HomePageView.swift
//  Birthdays
//
//  Created by Abrorbek Shanazarov on 22.11.2023.
//

import SwiftUI
import SwiftData

/*
 Move swiftData to viewModel
 Add dateService to viewModel and remove date logic
*/
struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @Environment(\.modelContext) var modelContext
    @Query var birthdays: [Birthday]

    private let currentDate = Date()
    private let currentMonth: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: Date())
    }()
    private let currentYear: Int = {
        Calendar.current.component(.year, from: Date())
    }()
    private let nextYear: Int = {
        Calendar.current.component(.year, from: Date()) + 1
    }()
    
    var body: some View {
        return NavigationView {
            VStack {
                if birthdays.isEmpty {
                    Text("Add your first birthday. No birthdays yet.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                 } else {
                     List {
                         birthdaySections
                         nextBirthdaySections
                     }
                 }
            }
            .navigationBarTitle("Birthdays", displayMode: .large)
            .navigationBarItems(
                leading: leadingButtons,
                trailing: NavigationLink(
                    destination: SettingsView(
                        notificationsEnabled: $viewModel.notificationsEnabled,
                        isActive: $viewModel.notificationsAreActive
                    )
                    .navigationBarTitle("Settings", displayMode: .inline)
                ) {
                    Image(systemName: "gearshape").foregroundColor(.orange)
                }
            )
            .overlay(alignment: .bottomTrailing) {
                Button(action: {
                    viewModel.showingNewDetailsView.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(
                            width: 50,
                            height: 50
                        )
                        .foregroundColor(.orange)
                }
                .background()
                .clipShape(Circle())
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 28
                    )
                )
                .popover(isPresented: $viewModel.showingNewDetailsView) {
                    let viewModel = BirthdayDetailsViewModel(
                        birthday: nil,
                        type: .new,
                        context: modelContext
                    )
                    BirthdayDetailsView(viewModel: viewModel)
                }
            }
        }
        .accentColor(.orange)
        .onAppear {
            viewModel.setupNotifications()
        }
    }

    var birthdaySections: some View {
        ForEach(sortedMonths(currentMonth), id: \.self) { monthName in
            let birthdaysForMonth = birthdaysForMonth(monthName)
            let upcomingBirthdays = birthdaysForMonth.filter { birthday in
                birthday.date!.month > Calendar.current.component(.month, from: currentDate) ||
                (birthday.date!.month == Calendar.current.component(.month, from: currentDate) &&
                birthday.date!.day >= Calendar.current.component(.day, from: currentDate))
            }
            
            if !upcomingBirthdays.isEmpty {
                Section(header: Text(monthName)) {
                    ForEach(upcomingBirthdays) { birthday in
                        BirthdayCell(name: birthday.name, date: birthday.date)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    viewModel.deleteBirthday(birthday)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .background {
                                NavigationLink("", destination: BirthdayDetailsView(viewModel: BirthdayDetailsViewModel(
                                        birthday: birthday,
                                        type: .edit,
                                        context: modelContext
                                        )
                                    )
                                )
                                .opacity(0)
                            }
                    }
                }
            }
        }
    }

    var nextBirthdaySections: some View {
        ForEach(sortedMonths(currentMonth).reversed(), id: \.self) { monthName in
            let birthdaysForMonth = birthdaysForMonth(monthName)
            let nextYearBirthdays = birthdaysForMonth.filter { birthday in
                birthday.date!.month < Calendar.current.component(.month, from: currentDate) ||
                (birthday.date!.month == Calendar.current.component(.month, from: currentDate) &&
                birthday.date!.day < Calendar.current.component(.day, from: currentDate))
            }
            if !nextYearBirthdays.isEmpty {
                Section(header: Text("\(monthName) \(nextYear)")) {
                    ForEach(nextYearBirthdays) { birthday in
                        BirthdayCell(name: birthday.name, date: birthday.date)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    viewModel.deleteBirthday(birthday)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .background {
                                NavigationLink("", destination: BirthdayDetailsView(viewModel: BirthdayDetailsViewModel(
                                        birthday: birthday,
                                        type: .edit,
                                        context: modelContext
                                        )
                                    )
                                )
                                .opacity(0)
                            }
                    }
                }
            }
        }
    }

    var leadingButtons: some View {
        HStack {
            Button(action: { viewModel.showingSearchView.toggle() }) {
                Image(systemName: "magnifyingglass").foregroundColor(.orange)
            }
            .popover(isPresented: $viewModel.showingSearchView) {
                SearchView()
            }
            Button(action: { viewModel.showingCalendarView.toggle() }) {
                Image(systemName: "calendar").foregroundColor(.orange)
            }
            .popover(isPresented: $viewModel.showingCalendarView) {
                BirthdayCalendarView()
            }
        }
    }
    
    func birthdaysForMonth(_ month: String) -> [Birthday] {
        let monthIndex = Calendar.current.monthSymbols.firstIndex(of: month) ?? 0
        
        return birthdays.filter { birthday in
            guard let date = birthday.date else { return false }
            return date.month == monthIndex + 1
        }.sorted { birthday1, birthday2 in
            birthday1.date!.day < birthday2.date!.day
        }
    }
    
    func sortedMonths(_ currentMonth: String) -> [String] {
        let currentMonthIndex = Calendar.current.monthSymbols.firstIndex(of: currentMonth) ?? 0
        
        // Sort the months array based on their distance from the current month
        return viewModel.months.sorted { (month1, month2) -> Bool in
            let month1Index = Calendar.current.monthSymbols.firstIndex(of: month1) ?? 0
            let month2Index = Calendar.current.monthSymbols.firstIndex(of: month2) ?? 0
            
            let distance1 = (month1Index - currentMonthIndex + 12) % 12
            let distance2 = (month2Index - currentMonthIndex + 12) % 12
            
            return distance1 < distance2
        }
    }
}

