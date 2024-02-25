@_private(sourceFile: "HomeView.swift") import Birthdays
import func SwiftUI.__designTimeBoolean
import func SwiftUI.__designTimeInteger
import protocol SwiftUI.PreviewProvider
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeFloat
import struct SwiftUI.EmptyView
import protocol SwiftUI.View
import SwiftData
import SwiftUI

extension HomeView {
    @_dynamicReplacement(for: upcomingBirthdaysByMonth) private var __preview__upcomingBirthdaysByMonth: [Int: [Birthday]] {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/HomeView.swift", line: 261)
        var groupedBirthdays: [Int: [Birthday]] = [:]
        
        for birthday in birthdays.filter({ $0.date != nil && currentDate <= $0.date! }) {
            guard let month = birthday.date?.month else { continue }
            if var birthdaysInMonth = groupedBirthdays[month] {
                birthdaysInMonth.append(birthday)
                groupedBirthdays[month] = birthdaysInMonth
            } else {
                groupedBirthdays[month] = [birthday]
            }
        }

        return groupedBirthdays
    
#sourceLocation()
    }
}

extension HomeView {
    @_dynamicReplacement(for: pastBirthdaysByMonth) private var __preview__pastBirthdaysByMonth: [Int: [Birthday]] {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/HomeView.swift", line: 245)
        var groupedBirthdays: [Int: [Birthday]] = [:]
        
        for birthday in birthdays.filter({ $0.date != nil && currentDate > $0.date! }) {
            guard let month = birthday.date?.month else { continue }
            if var birthdaysInMonth = groupedBirthdays[month] {
                birthdaysInMonth.append(birthday)
                groupedBirthdays[month] = birthdaysInMonth
            } else {
                groupedBirthdays[month] = [birthday]
            }
        }

        return groupedBirthdays
    
#sourceLocation()
    }
}

extension HomeView {
    @_dynamicReplacement(for: daysLeft(date:)) private func __preview__daysLeft(date: BirthdayDate?) -> String {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/HomeView.swift", line: 198)
        let calendar = Calendar.current
        guard let day = date?.day,
              let month = date?.month,
              let date = date
        else { return "" }
        
        var nextYear = year
        if date < currentDate {
            nextYear += __designTimeInteger("#16764.[2].[13].[3].[0].[0].[0]", fallback: 1)
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
            return __designTimeString("#16764.[2].[13].[15].[0].[0]", fallback: "🥳Today")
        case 1:
            return __designTimeString("#16764.[2].[13].[15].[1].[0]", fallback: "Tomorrow")
        default:
            return "In \(difference) Days"
        }
    
#sourceLocation()
    }
}

extension HomeView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/HomeView.swift", line: 65)
        NavigationView {
            List {
                Text(__designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value", fallback: "Generate wish using AI"))
                    .font(.system(size: __designTimeInteger("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[0].value.arg[0].value", fallback: 20), weight: .bold))
                    .frame(
                        width: __designTimeInteger("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[1].arg[0].value", fallback: 310),
                        height: __designTimeInteger("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[1].arg[1].value", fallback: 50),
                        alignment: .leading
                    )
                    .padding()
                    .background(aiBackground)
                    .cornerRadius(__designTimeInteger("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[4].arg[0].value", fallback: 22))
                    .foregroundColor(.white)
                    .shine(shine, duration: __designTimeFloat("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[6].arg[1].value", fallback: 0.8))
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        shine.toggle()
                    }

                
                ForEach(monthDict.sorted(by: { $0.key < $1.key }), id: \.key) { month, monthName in
                    if let upcomingBirthdaysByMonth = upcomingBirthdaysByMonth[month] {
                        Section(header: Text(monthName)) {
                            ForEach(upcomingBirthdaysByMonth.sorted(by: { $0.date! < $1.date! })) { birthday in
                                let daysLeftMessage = daysLeft(date: birthday.date)
                                BirthdayCell(
                                    nameLabelText: birthday.name ?? __designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[2].value.[0].[0].[0].arg[1].value.[0].arg[1].value.[1].arg[0].value.[0]", fallback: ""),
                                    dateLabelText: "\(birthday.date!.day).\(birthday.date!.month).\(year)",
                                    daysCounterLabelText: daysLeftMessage
                                )
                                .swipeActions(edge: .trailing, allowsFullSwipe: __designTimeBoolean("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[2].value.[0].[0].[0].arg[1].value.[0].arg[1].value.[1].modifier[0].arg[1].value", fallback: false)) {
                                    Button(role: .destructive) {
                                        modelContext.delete(birthday)
                                    } label: {
                                        Label(__designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[2].value.[0].[0].[0].arg[1].value.[0].arg[1].value.[1].modifier[0].arg[2].value.[0].arg[2].value.[0].arg[0].value", fallback: "Delete"), systemImage: __designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[2].value.[0].[0].[0].arg[1].value.[0].arg[1].value.[1].modifier[0].arg[2].value.[0].arg[2].value.[0].arg[1].value", fallback: "trash"))
                                    }
                                }
                            }
                        }
                    }
                }
                
                ForEach(monthDict.sorted(by: { $0.key < $1.key }), id: \.key) { month, monthName in
                    if let pastBirthdaysByMonth = pastBirthdaysByMonth[month] {
                        Section(header: Text(monthName  + " \(year + __designTimeInteger("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[2].value.[0].[0].[0].arg[0].value.arg[0].value.[0].[1].value.arg[0].value.[0]", fallback: 1))")) {
                            ForEach(pastBirthdaysByMonth.sorted(by: { $0.date! < $1.date! })) { birthday in
                                let daysLeftMessage = daysLeft(date: birthday.date)
                                BirthdayCell(
                                    nameLabelText: birthday.name ?? __designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[2].value.[0].[0].[0].arg[1].value.[0].arg[1].value.[1].arg[0].value.[0]", fallback: ""),
                                    dateLabelText: "\(birthday.date!.day).\(birthday.date!.month).\(year + __designTimeInteger("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[2].value.[0].[0].[0].arg[1].value.[0].arg[1].value.[1].arg[1].value.[5].value.arg[0].value.[0]", fallback: 1))",
                                    daysCounterLabelText: daysLeftMessage
                                )
                                .swipeActions(edge: .trailing, allowsFullSwipe: __designTimeBoolean("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[2].value.[0].[0].[0].arg[1].value.[0].arg[1].value.[1].modifier[0].arg[1].value", fallback: false)) {
                                    Button(role: .destructive) {
                                        modelContext.delete(birthday)
                                    } label: {
                                        Label(__designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[2].value.[0].[0].[0].arg[1].value.[0].arg[1].value.[1].modifier[0].arg[2].value.[0].arg[2].value.[0].arg[0].value", fallback: "Delete"), systemImage: __designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[2].value.[0].[0].[0].arg[1].value.[0].arg[1].value.[1].modifier[0].arg[2].value.[0].arg[2].value.[0].arg[1].value", fallback: "trash"))
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .navigationBarTitle(__designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].modifier[1].arg[0].value", fallback: "Birthdays"), displayMode: .large)
            .navigationBarItems(
                    leading:
                        HStack(){
                            Button(action: {
                                showingSearchView = __designTimeBoolean("#16764.[2].[12].property.[0].[0].arg[0].value.[0].modifier[2].arg[0].value.arg[0].value.[0].arg[0].value.[0].[0]", fallback: true)
                            }) {
                                Image(systemName: __designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].modifier[2].arg[0].value.arg[0].value.[0].arg[1].value.[0].arg[0].value", fallback: "magnifyingglass"))
                                    .foregroundColor(.orange)
                            }
                            .popover(isPresented: $showingSearchView) {
                                SearchView()
                            }
                            Button(action: {
                                showingCalendarView = __designTimeBoolean("#16764.[2].[12].property.[0].[0].arg[0].value.[0].modifier[2].arg[0].value.arg[0].value.[1].arg[0].value.[0].[0]", fallback: true)
                            }) {
                                Image(systemName: __designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].modifier[2].arg[0].value.arg[0].value.[1].arg[1].value.[0].arg[0].value", fallback: "calendar"))
                                    .foregroundColor(.orange)
                            }
                            .popover(isPresented: $showingCalendarView) {
                                BirthdayCalendarView()
                            }
                        },
                    trailing: Button(action: {
                        // Handle right button action
                    }) {
                        Image(systemName: __designTimeString("#16764.[2].[12].property.[0].[0].arg[0].value.[0].modifier[2].arg[1].value.arg[1].value.[0].arg[0].value", fallback: "gearshape"))
                            .foregroundColor(.orange)
                    }
                )
            }
            .overlay(alignment: .bottomTrailing) {
                Button(action: {
                    showingPopover = __designTimeBoolean("#16764.[2].[12].property.[0].[0].modifier[0].arg[1].value.[0].arg[0].value.[0].[0]", fallback: true)
                }) {
                    Image(systemName: __designTimeString("#16764.[2].[12].property.[0].[0].modifier[0].arg[1].value.[0].arg[1].value.[0].arg[0].value", fallback: "plus.circle.fill"))
                        .resizable()
                        .frame(
                            width: __designTimeInteger("#16764.[2].[12].property.[0].[0].modifier[0].arg[1].value.[0].arg[1].value.[0].modifier[1].arg[0].value", fallback: 45),
                            height: __designTimeInteger("#16764.[2].[12].property.[0].[0].modifier[0].arg[1].value.[0].arg[1].value.[0].modifier[1].arg[1].value", fallback: 45)
                        )
                        .foregroundColor(.orange)
                }
                .background()
                .clipShape(Circle())
                .padding(
                    EdgeInsets(
                        top: __designTimeInteger("#16764.[2].[12].property.[0].[0].modifier[0].arg[1].value.[0].modifier[2].arg[0].value.arg[0].value", fallback: 0),
                        leading: __designTimeInteger("#16764.[2].[12].property.[0].[0].modifier[0].arg[1].value.[0].modifier[2].arg[0].value.arg[1].value", fallback: 0),
                        bottom: __designTimeInteger("#16764.[2].[12].property.[0].[0].modifier[0].arg[1].value.[0].modifier[2].arg[0].value.arg[2].value", fallback: 0),
                        trailing: __designTimeInteger("#16764.[2].[12].property.[0].[0].modifier[0].arg[1].value.[0].modifier[2].arg[0].value.arg[3].value", fallback: 28)
                    )
                )
                .shadow(radius: __designTimeFloat("#16764.[2].[12].property.[0].[0].modifier[0].arg[1].value.[0].modifier[3].arg[0].value", fallback: 2.5))
                .popover(isPresented: $showingPopover) {
                    BirthdayDetailsView()
                }
            }
            .onAppear {
                NotificationManager.shared.requestAuthorization()
                UNUserNotificationCenter.current().delegate = NotificationManager.shared
            }
    
#sourceLocation()
    }
}

import struct Birthdays.HomeView
#Preview {
    HomeView()
}



