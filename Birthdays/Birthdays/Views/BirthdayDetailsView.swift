import SwiftUI
import SwiftData

struct BirthdayDetailsView: View {
    @State private var name: String = ""
    @State private var note: String = ""
    @State private var notificationEnabled: Bool = true
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())
    @State private var selectedYear: String = "----"
    
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

                Section(header: Text("Choose the date")) {
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
              
                Section(header: Text("Note")) {
                    TextField("Any additional information", text: $note)
                        .frame(height: 40)
                        .font(Font.system(size: 20))
                }
                
                Section(header: Text("Enable birthday notifications")) {
                    Toggle("Notifications", isOn: $notificationEnabled)
                }
                .frame(height: 40)
            }
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
                            notificationEnabled: notificationEnabled,
                            date: BirthdayDate(
                                day: selectedDay,
                                month: selectedMonth
                            )
                        )
                        
                        modelContext.insert(birthday)
                        presentationMode.wrappedValue.dismiss()
                        scheduleNotification(name: name)
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
    
    var buttonDisabled: Bool {
        return name.isEmpty
    }
    
    //MARK: - Helper functions
    
    func scheduleNotification(name: String) {
        let words = name.components(separatedBy: " ")
        let title = "\(words[0])'s Birthday Tomorrow 🎉"
        let body = "Don't miss out! A birthday is on its way. Prepare to make it memorable! 🎊🎁"
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.month = selectedMonth
        dateComponents.day = selectedDay
        dateComponents.hour = 10
        dateComponents.minute = 0

        NotificationManager.shared.scheduleNotification(title: title, body: body, dateComponents: dateComponents)
    }
    
}

#Preview {
    BirthdayDetailsView()
}

