import SwiftUI
import SwiftData

enum BirthdayDetailsViewType {
    case new
    case edit
}

struct BirthdayDetailsViewEdit: View {
    private var navigationTitle = "New birthday"
    private var birthday: Birthday?
    private var type: BirthdayDetailsViewType = .new

    @State private var name: String = ""
    @State private var note: String = ""

    //MARK: - Date
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedYear: String = "----"

    //MARK: - Notifications
    @State private var thatDayNotificationEnabled: Bool = true
    @State private var dayBeforeNotificationEnabled: Bool = false
    @State private var weekBeforeNotificationEnabled: Bool = false

    var buttonDisabled: Bool {
        return name.isEmpty
    }

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext

    init(birthday: Birthday? = nil) {
        guard let birthday = birthday else { return }
        self.birthday = birthday
        self.type = .edit
        navigationTitle = "Edit birthday"
    }

    var body: some View {
                Form {
                    Section(header: Text("Enter the name")) {
                        TextField("Name", text: $name)
                            .frame(height: 40)
                            .font(Font.system(size: 20))
                            .autocorrectionDisabled()
                            .onAppear {
                                name = birthday?.name ?? ""
                            }
                    }

                    Section(header: Text("Pick the date")) {
                        HStack {
                            Picker("Month", selection: $selectedMonth) {
                                ForEach(1 ..< months.count + 1, id: \.self) { index in
                                    Text("\(months[index - 1])").tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 150)
                            .onAppear {
                                selectedMonth = birthday?.date?.month ?? Calendar.current.component(.month, from: Date())
                            }

                            Picker("Day", selection: $selectedDay) {
                                ForEach(days, id: \.self) { day in
                                    Text("\(day)").tag(day)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 60)
                            .onAppear {
                                selectedDay = birthday?.date?.day ?? Calendar.current.component(.day, from: Date())
                            }

                            Picker("Select a Year", selection: $selectedYear) {
                                ForEach(years, id: \.self) { year in
                                    Text(year).tag(year)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .labelsHidden()
                            .frame(height: 120)
                            .onAppear {
                                selectedYear = birthday?.year ?? "----"
                            }
                        }
                    }

                    Section(header: Text("Notes")) {
                        TextField("Any additional information", text: $note)
                            .frame(height: 40)
                            .font(Font.system(size: 20))
                            .autocorrectionDisabled()
                            .onAppear {
                                note = birthday?.note ?? ""
                            }
                    }

                    Section(header: Text("Remind me")) {
                        Toggle("On birthday at 10:00 AM", isOn: $thatDayNotificationEnabled)
                            .onAppear {
                                thatDayNotificationEnabled = birthday?.thatDayNotificationEnabled ?? true
                            }
                        Toggle("1 day before", isOn: $dayBeforeNotificationEnabled)
                            .onAppear {
                                dayBeforeNotificationEnabled = birthday?.dayBeforeNotificationEnabled ?? false
                            }
                        Toggle("1 week before", isOn: $weekBeforeNotificationEnabled)
                            .onAppear {
                                weekBeforeNotificationEnabled = birthday?.weekBeforeNotificationEnabled ?? false
                            }
                    }
                    .frame(height: 40)
                }
                .modifier(DismissingKeyboard())
                .navigationBarItems(
                    trailing:
                        Button("Save") {
                            let newBirthday =  Birthday(
                                id: birthday?.id,
                                name: name,
                                year: selectedYear,
                                note: note,
                                thatDayNotificationEnabled: thatDayNotificationEnabled,
                                dayBeforeNotificationEnabled: dayBeforeNotificationEnabled,
                                weekBeforeNotificationEnabled: weekBeforeNotificationEnabled,
                                date: BirthdayDate(
                                    day: selectedDay,
                                    month: selectedMonth
                                )
                            )
                            
                            switch type {
                            case .new:
                                modelContext.insert(newBirthday)
                            case .edit:
                                modelContext.delete(birthday!)
                                modelContext.insert(newBirthday)
                            }

                            if UserDefaults.standard.value(forKey: "NotificationsEnabledInAppSettings") as! Bool {
                                NotificationManager.shared.scheduleNotificationWithBirthday(
                                    newBirthday: newBirthday,
                                    oldBirthday: birthday
                                )
                            }

                            presentationMode.wrappedValue.dismiss()
                        }
                        .buttonStyle(
                            CustomButtonStyle(
                                isEnabled: !buttonDisabled
                            )
                        )
                        .disabled(buttonDisabled)
                )
                .navigationBarTitle(navigationTitle, displayMode: .large)
    }

    let months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]

    var days: [Int] {
        switch selectedMonth {
        case 1:
            return Array(1...31)
        case 2:
            return Array(1...28)
        case 3:
            return Array(1...31)
        case 4:
            return Array(1...30)
        case 5:
            return Array(1...31)
        case 6:
            return Array(1...30)
        case 7:
            return Array(1...31)
        case 8:
            return Array(1...31)
        case 9:
            return Array(1...30)
        case 10:
            return Array(1...31)
        case 11:
            return Array(1...30)
        case 12:
            return Array(1...31)
        default:
            return Array(1...31)
        }
    }

    let years: [String] = (1940...2024).map { String($0) } + ["----"]
}

#Preview {
    BirthdayDetailsView()
}

