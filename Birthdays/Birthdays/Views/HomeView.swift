//
//  HomePageView.swift
//  Birthdays
//
//  Created by Аброрбек on 22.11.2023.
//

import SwiftUI
import SwiftData

struct HomeView: View {
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

    //MARK: - Animation
    @State private var rotateIn3D = false
    @State private var show = true
    @State private var shine = true
    
    private let aiBackground = LinearGradient(
        gradient: Gradient(
            colors: [
                Color(hex: 0x11998E),
                Color(hex: 0x38EF7D)
            ]
        ),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    //MARK: - View Present
    
    @State private var showingPopover = false
    @State private var showingSearchView = false
    
    private var monthDict: [Int: String] = [
        1: "January",
        2: "February",
        3: "March",
        4: "April",
        5: "May",
        6: "June",
        7: "July",
        8: "August",
        9: "September",
        10: "October",
        11: "November",
        12: "December"
    ]
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    Text("Generate wish using AI")
                        .font(.system(size: 20, weight: .bold))
                        .frame(
                            width: 300,
                            height: 50,
                            alignment: .leading
                        )
                        .padding()
                        .background(aiBackground)
                        .cornerRadius(22)
                        .foregroundColor(.white)
                    
                }
                .shine(shine, duration: 0.8)
                .listRowBackground(Color.clear)
//                                .rotation3DEffect(
//                                    .degrees(rotateIn3D ? 6 : -6),
//                                    axis: (
//                                        x: rotateIn3D ? 90 : -45,
//                                        y: rotateIn3D ? -45 : -90,
//                                        z: 0
//                                    )
//                                )
//                                .animation(
//                                    Animation.easeInOut(
//                                        duration: 2
//                                    )
//                                    .repeatForever(autoreverses: true),
//                                    value: UUID()
//                                )
                .onAppear() {
//                                        rotateIn3D.toggle()
                    shine.toggle()
                }
                .onTapGesture {
                    shine.toggle()
                }
                ForEach(monthDict.sorted(by: { $0.key < $1.key }), id: \.key) { month, monthName in
                    if let upcomingBirthdaysByMonth = upcomingBirthdaysByMonth[month] {
                        Section(header: Text(monthName)) {
                            ForEach(upcomingBirthdaysByMonth.sorted(by: { $0.date! < $1.date! })) { birthday in
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
                        }
                    }
                }
                
                ForEach(monthDict.sorted(by: { $0.key < $1.key }), id: \.key) { month, monthName in
                    if let pastBirthdaysByMonth = pastBirthdaysByMonth[month] {
                        Section(header: Text(monthName  + " \(year + 1)")) {
                            ForEach(pastBirthdaysByMonth.sorted(by: { $0.date! < $1.date! })) { birthday in
                                let daysLeftMessage = daysLeft(date: birthday.date)
                                BirthdayCell(
                                    nameLabelText: birthday.name ?? "",
                                    dateLabelText: "\(birthday.date!.day).\(birthday.date!.month).\(year + 1)",
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
                        }
                    }
                }
            }
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .navigationBarTitle("Birthdays", displayMode: .large)
            .navigationBarItems(
                    leading:
                        HStack(){
                            Button(action: {
                                showingSearchView = true
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.orange)
                            }
                            .popover(isPresented: $showingSearchView) {
                                SearchView()
                            }
                            Button(action: {
                                
                            }) {
                                Image(systemName: "calendar")
                                    .foregroundColor(.orange)
                            }
                        },
                    trailing: Button(action: {
                        // Handle right button action
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.orange)
                    }
                )
            }
            .overlay(alignment: .bottomTrailing) {
                Button(action: {
                    showingPopover = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(
                            width: 45,
                            height: 45
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
                .shadow(radius: 2.5)
                .popover(isPresented: $showingPopover) {
                    BirthdayDetailsView()
                }
            }
            .onAppear {
                NotificationManager.shared.requestAuthorization()
                UNUserNotificationCenter.current().delegate = NotificationManager.shared
            }
    }
    
    
    //MARK: - Helper Functions
    
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

extension HomeView {
    //MARK: -Past and upcoming birthdays distributed by sections
    
    var pastBirthdaysByMonth: [Int: [Birthday]] {
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
    }
    
    var upcomingBirthdaysByMonth: [Int: [Birthday]] {
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
    }
}

#Preview {
    HomeView()
}
