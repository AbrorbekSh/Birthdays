import SwiftUI
import SwiftData

struct BirthdayDetailsView: View {
    @State private var name: String = ""
    @State private var note: String = ""

    //MARK: - Date
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())
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
    
    let years: [String] = (1940...2023).map { String($0) } + ["----"]
    
    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("Enter the name")) {
                        TextField("Name", text: $name)
                            .frame(height: 40)
                            .font(Font.system(size: 20))
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

                            Picker("Day", selection: $selectedDay) {
                                ForEach(days, id: \.self) { day in
                                    Text("\(day)").tag(day)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 60)

                            Picker("Select a Year", selection: $selectedYear) {
                                ForEach(years, id: \.self) { year in
                                    Text(year).tag(year)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .labelsHidden()
                            .frame(height: 120)
                        }
                    }

                    Section(header: Text("Notes")) {
                        TextField("Any additional information", text: $note)
                            .frame(height: 40)
                            .font(Font.system(size: 20))
                    }

                    Section(header: Text("Remind me:")) {
                        Toggle("On birthday at 10:00 AM", isOn: $thatDayNotificationEnabled)
                        Toggle("1 day before", isOn: $dayBeforeNotificationEnabled)
                        Toggle("1 week before", isOn: $weekBeforeNotificationEnabled)
                    }
                    .frame(height: 40)
                }
                .modifier(DismissingKeyboard())
                .navigationBarItems(
                    leading:
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundStyle(.orange),
                    trailing:
                        Button("Save") {
                            let birthday = Birthday(
                                name: name,
                                year: 2023,
                                note: note,
                                notificationEnabled: thatDayNotificationEnabled,
                                date: BirthdayDate(
                                    day: selectedDay,
                                    month: selectedMonth
                                )
                            )

                            NotificationManager.shared.scheduleNotificationWithDate(
                                day: selectedDay,
                                month: selectedMonth,
                                thatDayEnabled: thatDayNotificationEnabled,
                                dayBeforeEnabled: dayBeforeNotificationEnabled,
                                weekBeforeEnabled: weekBeforeNotificationEnabled,
                                name: name
                            )
                            modelContext.insert(birthday)
                            presentationMode.wrappedValue.dismiss()
                        }
                        .buttonStyle(
                            CustomButtonStyle(
                                isEnabled: !buttonDisabled
                            )
                        )
                        .disabled(buttonDisabled)
                )
                .navigationBarTitle("New birthday", displayMode: .large)
        }
    }
}

#Preview {
    BirthdayDetailsView()
}

