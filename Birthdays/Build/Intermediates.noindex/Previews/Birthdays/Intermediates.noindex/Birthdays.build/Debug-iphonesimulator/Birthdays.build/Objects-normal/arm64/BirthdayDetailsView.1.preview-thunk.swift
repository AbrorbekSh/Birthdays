@_private(sourceFile: "BirthdayDetailsView.swift") import Birthdays
import func SwiftUI.__designTimeBoolean
import func SwiftUI.__designTimeInteger
import protocol SwiftUI.PreviewProvider
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeFloat
import struct SwiftUI.EmptyView
import protocol SwiftUI.View
import SwiftData
import SwiftUI

extension BirthdayDetailsView {
    @_dynamicReplacement(for: days) private var __preview__days: [Int] {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/BirthdayDetailsView.swift", line: 183)
        switch selectedMonth {
        case 1:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[0].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[0].[0].arg[0].value.[1]", fallback: 31))
        case 2:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[1].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[1].[0].arg[0].value.[1]", fallback: 28))
        case 3:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[2].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[2].[0].arg[0].value.[1]", fallback: 31))
        case 4:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[3].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[3].[0].arg[0].value.[1]", fallback: 30))
        case 5:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[4].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[4].[0].arg[0].value.[1]", fallback: 31))
        case 6:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[5].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[5].[0].arg[0].value.[1]", fallback: 30))
        case 7:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[6].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[6].[0].arg[0].value.[1]", fallback: 31))
        case 8:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[7].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[7].[0].arg[0].value.[1]", fallback: 31))
        case 9:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[8].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[8].[0].arg[0].value.[1]", fallback: 30))
        case 10:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[9].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[9].[0].arg[0].value.[1]", fallback: 31))
        case 11:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[10].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[10].[0].arg[0].value.[1]", fallback: 30))
        case 12:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[11].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[11].[0].arg[0].value.[1]", fallback: 31))
        default:
            return Array(__designTimeInteger("#4910.[3].[17].property.[0].[0].[12].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#4910.[3].[17].property.[0].[0].[12].[0].arg[0].value.[1]", fallback: 31))
        }
    
#sourceLocation()
    }
}

extension BirthdayDetailsView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/BirthdayDetailsView.swift", line: 42)
        NavigationView {
                Form {
                    Section(header: Text(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.arg[0].value", fallback: "Enter the name"))) {
                        TextField(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value", fallback: "Name"), text: $name)
                            .frame(height: __designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value", fallback: 40))
                            .font(Font.system(size: __designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].modifier[1].arg[0].value.arg[0].value", fallback: 20)))
                            .onAppear {
                                name = birthday?.name ?? __designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].modifier[2].arg[0].value.[0].[0]", fallback: "")
                            }
                    }

                    Section(header: Text(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.arg[0].value", fallback: "Pick the date"))) {
                        HStack {
                            Picker(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].arg[0].value", fallback: "Month"), selection: $selectedMonth) {
                                ForEach(__designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].arg[2].value.[0].arg[0].value.[0]", fallback: 1) ..< months.count + __designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].arg[2].value.[0].arg[0].value.[1]", fallback: 1), id: \.self) { index in
                                    Text("\(months[index - __designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].arg[2].value.[0].arg[2].value.[0].arg[0].value.[1].value.arg[0].value.[0].value.[0]", fallback: 1)])").tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: __designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].modifier[1].arg[0].value", fallback: 150))
                            .onAppear {
                                selectedMonth = birthday?.date?.month ?? Calendar.current.component(.month, from: Date())
                            }

                            Picker(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[1].arg[0].value", fallback: "Day"), selection: $selectedDay) {
                                ForEach(days, id: \.self) { day in
                                    Text("\(day)").tag(day)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: __designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[1].modifier[1].arg[0].value", fallback: 60))
                            .onAppear {
                                selectedDay = birthday?.date?.day ?? Calendar.current.component(.day, from: Date())
                            }

                            Picker(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[2].arg[0].value", fallback: "Select a Year"), selection: $selectedYear) {
                                ForEach(years, id: \.self) { year in
                                    Text(year).tag(year)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .labelsHidden()
                            .frame(height: __designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[2].modifier[2].arg[0].value", fallback: 120))
                            .onAppear {
                                selectedYear = birthday?.year ?? __designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[2].modifier[3].arg[0].value.[0].[0]", fallback: "----")
                            }
                        }
                    }

                    Section(header: Text(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[0].value.arg[0].value", fallback: "Notes"))) {
                        TextField(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[1].value.[0].arg[0].value", fallback: "Any additional information"), text: $note)
                            .frame(height: __designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[1].value.[0].modifier[0].arg[0].value", fallback: 40))
                            .font(Font.system(size: __designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[1].value.[0].modifier[1].arg[0].value.arg[0].value", fallback: 20)))
                            .onAppear {
                                note = birthday?.note ?? __designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[2].arg[1].value.[0].modifier[2].arg[0].value.[0].[0]", fallback: "")
                            }
                    }

                    Section(header: Text(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.arg[0].value", fallback: "Remind me"))) {
                        Toggle(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[0].arg[0].value", fallback: "On birthday at 10:00 AM"), isOn: $thatDayNotificationEnabled)
                            .onAppear {
                                thatDayNotificationEnabled = birthday?.thatDayNotificationEnabled ?? __designTimeBoolean("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[0].modifier[0].arg[0].value.[0].[0]", fallback: true)
                            }
                        Toggle(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[1].arg[0].value", fallback: "1 day before"), isOn: $dayBeforeNotificationEnabled)
                            .onAppear {
                                dayBeforeNotificationEnabled = birthday?.dayBeforeNotificationEnabled ?? __designTimeBoolean("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[1].modifier[0].arg[0].value.[0].[0]", fallback: false)
                            }
                        Toggle(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[2].arg[0].value", fallback: "1 week before"), isOn: $weekBeforeNotificationEnabled)
                            .onAppear {
                                weekBeforeNotificationEnabled = birthday?.weekBeforeNotificationEnabled ?? __designTimeBoolean("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[2].modifier[0].arg[0].value.[0].[0]", fallback: false)
                            }
                    }
                    .frame(height: __designTimeInteger("#4910.[3].[15].property.[0].[0].arg[0].value.[0].arg[0].value.[3].modifier[0].arg[0].value", fallback: 40))
                }
                .modifier(DismissingKeyboard())
                .navigationBarItems(
                    leading:
                        Button(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].modifier[1].arg[0].value.arg[0].value", fallback: "Cancel")) {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundStyle(.orange),
                    trailing:
                        Button(__designTimeString("#4910.[3].[15].property.[0].[0].arg[0].value.[0].modifier[1].arg[1].value.arg[0].value", fallback: "Save")) {
                            let birthday = Birthday(
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
                                modelContext.insert(birthday)
                            case .edit:
                                modelContext.delete(self.birthday!)
                                modelContext.insert(birthday)
                            }
                            
                            if UserDefaults.standard.value(forKey: "NotificationsEnabledInAppSettings") as! Bool {
                                NotificationManager.shared.scheduleNotificationWithBirthday(
                                    newBirthday: birthday,
                                    oldBithday: self.birthday
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
        .navigationBarHidden(__designTimeBoolean("#4910.[3].[15].property.[0].[0].modifier[0].arg[0].value", fallback: true))
    
#sourceLocation()
    }
}

extension BirthdayDetailsView {
    @_dynamicReplacement(for: buttonDisabled) private var __preview__buttonDisabled: Bool {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/BirthdayDetailsView.swift", line: 28)
        return name.isEmpty
    
#sourceLocation()
    }
}

import enum Birthdays.BirthdayDetailsViewType
import struct Birthdays.BirthdayDetailsView
#Preview {
    BirthdayDetailsView()
}



