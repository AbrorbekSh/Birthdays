import SwiftUI
import SwiftData

struct BirthdayDetailsView: View {
    @State private var name: String = ""
    @State private var note: String = ""
    @State private var notificationEnabled: Bool = true
    @State private var selectedMonth = 6
    @State private var selectedDay = 27
    @State private var selectedYear: Int? = nil
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    
    let months = [
        "January", "February", "March", "April",
        "May", "June", "July", "August",
        "September", "October", "November", "December"
    ]
    let days = Array(1...31)
    let years = Array(1950...2023)
    
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
                        
                        Picker("Year", selection: $selectedYear) {
                            ForEach(years, id: \.self) { year in
                                Text("\(year)").tag(year)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 120)
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
                            year: selectedYear,
                            note: note,
                            notificationEnabled: notificationEnabled,
                            date: BirthdayDate(
                                day: selectedDay,
                                month: selectedMonth
                            )
                        )
                        
                        modelContext.insert(birthday)
                        presentationMode.wrappedValue.dismiss()
                        scheduleNotification(name: name, date: Date())
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
    
    func scheduleNotification(name: String, date: Date) {
        let words = name.components(separatedBy: " ")
        let title = "\(words[0])'s Birthday Tomorrow 🎉"
        let body = "Don't miss out! A birthday is on its way. Prepare to make it memorable! 🎊🎁"
        let date = Date().addingTimeInterval(10) // Schedule notification after 10 seconds

        NotificationManager.shared.scheduleNotification(title: title, body: body, date: date)
    }
    
}

#Preview {
    BirthdayDetailsView()
}

