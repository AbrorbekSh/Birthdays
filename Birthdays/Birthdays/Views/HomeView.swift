//
//  HomePageView.swift
//  Birthdays
//
//  Created by Аброрбек on 22.11.2023.
//

import Combine
import SwiftUI
import SwiftData
import UserNotifications

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

    ///When in the system settings no permission for notifications, the toggle should be disabled
    @State var notificationsAreActive: Bool = UserDefaults.standard.bool(forKey: "NotificationsEnabledInAppSettings")
    ///Notification permission for in app settings
    @State var notificationsEnabled: Bool = UserDefaults.standard.bool(forKey: "NotificationsEnabledInAppSettings")
    @State private var cancellables = Set<AnyCancellable>()

    //MARK: - View Present
    
    @State private var showingNewDetailsView = false
    @State private var showingSearchView = false
    @State private var showingCalendarView = false
    @State private var showingSettingsView = false

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
                Text("Generate wish using AI")
                    .font(.system(size: 20, weight: .bold))
                    .frame(
                        width: 310,
                        height: 50,
                        alignment: .leading
                    )
                    .padding()
                    .background(aiBackground)
                    .cornerRadius(22)
                    .foregroundColor(.white)
                    .shine(shine, duration: 0.8)
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        shine.toggle()
                    }

                
                ForEach(monthDict.sorted(by: { $0.key < $1.key }), id: \.key) { month, monthName in
                    if let upcomingBirthdaysByMonth = upcomingBirthdaysByMonth[month] {
                        Section(header: Text(monthName)) {
                            ForEach(upcomingBirthdaysByMonth.sorted(by: { $0.date! < $1.date! })) { birthday in
                                BirthdayCell(name: birthday.name, date: birthday.date)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button(role: .destructive) {
                                            modelContext.delete(birthday)
                                            NotificationManager.shared
                                                .removeNotificationWithBirthday(birthday: birthday)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                    .background {
                                        NavigationLink("", destination: BirthdayDetailsViewEdit(birthday: birthday))
                                            .opacity(0)
                                    }
                            }
                        }
                    }
                }
                
                ForEach(monthDict.sorted(by: { $0.key < $1.key }), id: \.key) { month, monthName in
                    if let pastBirthdaysByMonth = pastBirthdaysByMonth[month] {
                        Section(header: Text(monthName  + " \(year + 1)")) {
                            ForEach(pastBirthdaysByMonth.sorted(by: { $0.date! < $1.date! })) { birthday in
                                BirthdayCell(name: birthday.name, date: birthday.date)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button(role: .destructive) {
                                            modelContext.delete(birthday)
                                            NotificationManager.shared
                                                .removeNotificationWithBirthday(birthday: birthday)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                    .background {
                                        NavigationLink("", destination: BirthdayDetailsViewEdit(birthday: birthday))
                                            .opacity(0)
                                    }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .navigationBarTitle("Birthdays", displayMode: .large)
            .onAppear() {
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    switch settings.authorizationStatus {
                    case .authorized:
                        notificationsAreActive = true
                        UserDefaults.standard.set(true, forKey: "NotificationsPermissionGranted")
                    default:
                        notificationsAreActive = false
                        UserDefaults.standard.set(false, forKey: "NotificationsPermissionGranted")
                    }
                }
                NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
                    .sink(receiveValue: { _ in
                        UNUserNotificationCenter.current().getNotificationSettings { settings in
                            switch settings.authorizationStatus {
                            case .authorized:
                                notificationsAreActive = true
                                UserDefaults.standard.set(true, forKey: "NotificationsPermissionGranted")
                            default:
                                notificationsAreActive = false
                                UserDefaults.standard.set(false, forKey: "NotificationsPermissionGranted")
                            }
                        }
                    })
                    .store(in: &cancellables)
            }
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
                                showingCalendarView = true
                            }) {
                                Image(systemName: "calendar")
                                    .foregroundColor(.orange)
                            }
                            .popover(isPresented: $showingCalendarView) {
                                BirthdayCalendarView()
                            }
                        },
                    trailing: Button(action: {
                        showingSettingsView = true
                    }) {
                        NavigationLink(destination: SettingsView(
                                            notificationsEnabled: $notificationsEnabled,
                                            isActive: $notificationsAreActive
                                        )
                                        .navigationBarTitle("Settings", displayMode: .inline)
                        )
                        {
                            Image(systemName: "gearshape")
                                .foregroundColor(.orange)
                        }
                    }
                )
                .overlay(alignment: .bottomTrailing) {
                    Button(action: {
                        showingNewDetailsView = true
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
                    .popover(isPresented: $showingNewDetailsView) {
                        BirthdayDetailsView()
                    }
                }
            }
            .accentColor(.orange)
            .onAppear {
                NotificationManager.shared.requestAuthorization()
                UNUserNotificationCenter.current().delegate = NotificationManager.shared
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
//            print(birthday.name)
        }

        return groupedBirthdays
    }
}

extension UserDefaults {
    @objc var notificationsEnabled: Bool {
        get {
            return bool(forKey: "NotificationsEnabledInAppSettings")
        }
        set {
            set(newValue, forKey: "NotificationsEnabledInAppSettings")
        }
    }
}

//#Preview {
//    @State var isActive: Bool = true
//    HomeView(isActive: $isActive)
//}
