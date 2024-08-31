

import Foundation
import SwiftData

class BirthdayDetailsViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var note: String = ""
    @Published var selectedDay: Int = Calendar.current.component(.day, from: Date())
    @Published var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @Published var selectedYear: String = "----"
    @Published var thatDayNotificationEnabled: Bool = true
    @Published var dayBeforeNotificationEnabled: Bool = false
    @Published var weekBeforeNotificationEnabled: Bool = false

    let months = ["January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December"]
    let years: [String] = (1940...2024).map { String($0) } + ["----"]
    
    private let context: ModelContext
    private let notificationManager = NotificationManager.shared
    private let birthday: Birthday?
    private let type: BirthdayDetailsViewType
    
    init(
        birthday: Birthday?,
        type: BirthdayDetailsViewType,
        context: ModelContext
    ) {
        self.birthday = birthday
        self.type = type
        self.context = context

        title = type == .new ? "New Birthday" : "Edit Birthday"
        
        loadInitialData()
    }
    
    let title: String

    var daysInSelectedMonth: [Int] {
        DateService.daysInMonth(month: selectedMonth, year: Int(selectedYear) ?? Calendar.current.component(.year, from: Date()))
    }

    func saveBirthday(completion: () -> Void) {
        let newBirthday = Birthday(
            id: birthday?.id,
            name: name,
            year: selectedYear,
            note: note,
            thatDayNotificationEnabled: thatDayNotificationEnabled,
            dayBeforeNotificationEnabled: dayBeforeNotificationEnabled,
            weekBeforeNotificationEnabled: weekBeforeNotificationEnabled,
            date: BirthdayDate(day: selectedDay, month: selectedMonth)
        )

        switch type {
        case .new:
            context.insert(newBirthday)
        case .edit:
            context.delete(birthday!)
            context.insert(newBirthday)
        }

        if UserDefaults.standard.value(forKey: "NotificationsEnabledInAppSettings") as! Bool {
            notificationManager.scheduleNotification(newBirthday: newBirthday, oldBirthday: birthday)
        }
        completion()
    }
    
    private func loadInitialData() {
        if let birthday = birthday {
            name = birthday.name ?? ""
            note = birthday.note ?? ""
            selectedDay = birthday.date?.day ?? Calendar.current.component(.day, from: Date())
            selectedMonth = birthday.date?.month ?? Calendar.current.component(.month, from: Date())
            selectedYear = birthday.year ?? "----"
            thatDayNotificationEnabled = birthday.thatDayNotificationEnabled ?? true
            dayBeforeNotificationEnabled = birthday.dayBeforeNotificationEnabled ?? false
            weekBeforeNotificationEnabled = birthday.weekBeforeNotificationEnabled ?? false
        }
    }
}
