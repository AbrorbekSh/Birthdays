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


//extension HomeView {
//    //MARK: -Past and upcoming birthdays distributed by sections
//    
//    var pastBirthdaysByMonth: [Int: [Birthday]] {
//        var groupedBirthdays: [Int: [Birthday]] = [:]
//        
//        for birthday in birthdays.filter({ $0.date != nil && currentDate > $0.date! }) {
//            guard let month = birthday.date?.month else { continue }
//            if var birthdaysInMonth = groupedBirthdays[month] {
//                birthdaysInMonth.append(birthday)
//                groupedBirthdays[month] = birthdaysInMonth
//            } else {
//                groupedBirthdays[month] = [birthday]
//            }
//        }
//
//        return groupedBirthdays
//    }
//    
//    var upcomingBirthdaysByMonth: [Int: [Birthday]] {
//        var groupedBirthdays: [Int: [Birthday]] = [:]
//        
//        for birthday in birthdays.filter({ $0.date != nil && currentDate <= $0.date! }) {
//            guard let month = birthday.date?.month else { continue }
//            if var birthdaysInMonth = groupedBirthdays[month] {
//                birthdaysInMonth.append(birthday)
//                groupedBirthdays[month] = birthdaysInMonth
//            } else {
//                groupedBirthdays[month] = [birthday]
//            }
//        }
//
//        return groupedBirthdays
//    }
//}


//import Combine
//import SwiftUI
//import SwiftData
//import UserNotifications
//
//struct HomeView: View {
//    //MARK: - Date
//    private let currentDate: BirthdayDate = {
//        let date = Calendar.current.dateComponents([.day, .month], from: Date())
//        return BirthdayDate(day: date.day ?? 0, month: date.month ?? 0)
//    }()
//    
//    private let year: Int = {
//        let year = Calendar.current.component(.year, from: Date())
//        return year
//    }()
//    
//    //MARK: - SwiftData
//    @Environment(\.modelContext) var modelContext
//    @Query var birthdays: [Birthday]
//
//    ///When in the system settings no permission for notifications, the toggle should be disabled
//    @State var notificationsAreActive: Bool = UserDefaults.standard.bool(forKey: "NotificationsEnabledInAppSettings")
//    ///Notification permission for in app settings
//    @State var notificationsEnabled: Bool = UserDefaults.standard.bool(forKey: "NotificationsEnabledInAppSettings")
//    @State private var cancellables = Set<AnyCancellable>()
//
//    //MARK: - View Present
//    
//    @State private var showingNewDetailsView = false
//    @State private var showingSearchView = false
//    @State private var showingCalendarView = false
//    @State private var showingSettingsView = false
//
//    private var monthDict: [Int: String] = [
//        1: "January",
//        2: "February",
//        3: "March",
//        4: "April",
//        5: "May",
//        6: "June",
//        7: "July",
//        8: "August",
//        9: "September",
//        10: "October",
//        11: "November",
//        12: "December"
//    ]
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(monthDict.sorted(by: { $0.key < $1.key }), id: \.key) { month, monthName in
//                    if let upcomingBirthdaysByMonth = upcomingBirthdaysByMonth[month] {
//                        Section(header: Text(monthName)) {
//                            ForEach(upcomingBirthdaysByMonth.sorted(by: { $0.date! < $1.date! })) { birthday in
//                                BirthdayCell(name: birthday.name, date: birthday.date)
//                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
//                                        Button(role: .destructive) {
//                                            modelContext.delete(birthday)
//                                            NotificationManager.shared
//                                                .removeNotificationWithBirthday(birthday: birthday)
//                                        } label: {
//                                            Label("Delete", systemImage: "trash")
//                                        }
//                                    }
//                                    .background {
//                                            NavigationLink("", destination: BirthdayDetailsView(viewModel: BirthdayDetailsViewModel(
//                                                birthday: birthday,
//                                                type: .edit,
//                                                context: modelContext
//                                                )
//                                            )
//                                        )
//                                            .opacity(0)
//                                    }
//                            }
//                        }
//                    }
//                }
//                
//                ForEach(monthDict.sorted(by: { $0.key < $1.key }), id: \.key) { month, monthName in
//                    if let pastBirthdaysByMonth = pastBirthdaysByMonth[month] {
//                        Section(header: Text(monthName  + " \(year + 1)")) {
//                            ForEach(pastBirthdaysByMonth.sorted(by: { $0.date! < $1.date! })) { birthday in
//                                BirthdayCell(name: birthday.name, date: birthday.date)
//                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
//                                        Button(role: .destructive) {
//                                            modelContext.delete(birthday)
//                                            NotificationManager.shared
//                                                .removeNotificationWithBirthday(birthday: birthday)
//                                        } label: {
//                                            Label("Delete", systemImage: "trash")
//                                        }
//                                    }
//                                    .background {
////                                        let viewModel = BirthdayDetailsViewModel(
////                                            birthday: birthday,
////                                            type: .edit,
////                                            context: modelContext
////                                        )
//                                        NavigationLink("", destination: BirthdayDetailsView(viewModel: BirthdayDetailsViewModel(
//                                            birthday: birthday,
//                                            type: .edit,
//                                            context: modelContext
//                                        )))
//                                            .opacity(0)
//                                    }
//                            }
//                        }
//                    }
//                }
//            }
//            .scrollIndicators(ScrollIndicatorVisibility.hidden)
//            .navigationBarTitle("Birthdays", displayMode: .large)
//            .onAppear() {
//                UNUserNotificationCenter.current().getNotificationSettings { settings in
//                    switch settings.authorizationStatus {
//                    case .authorized:
//                        notificationsAreActive = true
//                        UserDefaults.standard.set(true, forKey: "NotificationsPermissionGranted")
//                    default:
//                        notificationsAreActive = false
//                        UserDefaults.standard.set(false, forKey: "NotificationsPermissionGranted")
//                    }
//                }
//                NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
//                    .sink(receiveValue: { _ in
//                        UNUserNotificationCenter.current().getNotificationSettings { settings in
//                            switch settings.authorizationStatus {
//                            case .authorized:
//                                notificationsAreActive = true
//                                UserDefaults.standard.set(true, forKey: "NotificationsPermissionGranted")
//                            default:
//                                notificationsAreActive = false
//                                UserDefaults.standard.set(false, forKey: "NotificationsPermissionGranted")
//                            }
//                        }
//                    })
//                    .store(in: &cancellables)
//            }
//            .navigationBarItems(
//                    leading:
//                        HStack(){
//                            Button(action: {
//                                showingSearchView = true
//                            }) {
//                                Image(systemName: "magnifyingglass")
//                                    .foregroundColor(.orange)
//                            }
//                            .popover(isPresented: $showingSearchView) {
//                                SearchView()
//                            }
//                            Button(action: {
//                                showingCalendarView = true
//                            }) {
//                                Image(systemName: "calendar")
//                                    .foregroundColor(.orange)
//                            }
//                            .popover(isPresented: $showingCalendarView) {
//                                BirthdayCalendarView()
//                            }
//                        },
//                    trailing: Button(action: {
//                        showingSettingsView = true
//                    }) {
//                        NavigationLink(destination: SettingsView(
//                                            notificationsEnabled: $notificationsEnabled,
//                                            isActive: $notificationsAreActive
//                                        )
//                                        .navigationBarTitle("Settings", displayMode: .inline)
//                        )
//                        {
//                            Image(systemName: "gearshape")
//                                .foregroundColor(.orange)
//                        }
//                    }
//                )
//                .overlay(alignment: .bottomTrailing) {
//                    Button(action: {
//                        showingNewDetailsView = true
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                            .resizable()
//                            .frame(
//                                width: 50,
//                                height: 50
//                            )
//                            .foregroundColor(.orange)
//                    }
//                    .background()
//                    .clipShape(Circle())
//                    .padding(
//                        EdgeInsets(
//                            top: 0,
//                            leading: 0,
//                            bottom: 0,
//                            trailing: 28
//                        )
//                    )
//                    .popover(isPresented: $showingNewDetailsView) {
//                        let viewModel = BirthdayDetailsViewModel(
//                            birthday: nil,
//                            type: .new,
//                            context: modelContext
//                        )
//                        BirthdayDetailsView(viewModel: viewModel)
//                    }
//                }
//            }
//            .accentColor(.orange)
//            .onAppear {
//                NotificationManager.shared.requestAuthorization()
//                UNUserNotificationCenter.current().delegate = NotificationManager.shared
//            }
//    }
//}
//
//extension HomeView {
//    //MARK: -Past and upcoming birthdays distributed by sections
//    
//    var pastBirthdaysByMonth: [Int: [Birthday]] {
//        var groupedBirthdays: [Int: [Birthday]] = [:]
//        
//        for birthday in birthdays.filter({ $0.date != nil && currentDate > $0.date! }) {
//            guard let month = birthday.date?.month else { continue }
//            if var birthdaysInMonth = groupedBirthdays[month] {
//                birthdaysInMonth.append(birthday)
//                groupedBirthdays[month] = birthdaysInMonth
//            } else {
//                groupedBirthdays[month] = [birthday]
//            }
//        }
//
//        return groupedBirthdays
//    }
//    
//    var upcomingBirthdaysByMonth: [Int: [Birthday]] {
//        var groupedBirthdays: [Int: [Birthday]] = [:]
//        
//        for birthday in birthdays.filter({ $0.date != nil && currentDate <= $0.date! }) {
//            guard let month = birthday.date?.month else { continue }
//            if var birthdaysInMonth = groupedBirthdays[month] {
//                birthdaysInMonth.append(birthday)
//                groupedBirthdays[month] = birthdaysInMonth
//            } else {
//                groupedBirthdays[month] = [birthday]
//            }
//        }
//
//        return groupedBirthdays
//    }
//}
//
//extension UserDefaults {
//    @objc var notificationsEnabled: Bool {
//        get {
//            return bool(forKey: "NotificationsEnabledInAppSettings")
//        }
//        set {
//            set(newValue, forKey: "NotificationsEnabledInAppSettings")
//        }
//    }
//}
