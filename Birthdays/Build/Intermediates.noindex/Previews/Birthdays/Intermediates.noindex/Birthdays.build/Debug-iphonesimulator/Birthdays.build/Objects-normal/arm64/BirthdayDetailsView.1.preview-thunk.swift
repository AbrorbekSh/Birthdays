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
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/BirthdayDetailsView.swift", line: 74)
        Background {
        NavigationView {
                Form {
                    Section(header: Text(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.arg[0].value", fallback: "Enter the name"))) {
                        TextField(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value", fallback: "Name"), text: $name)
                            .frame(height: __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value", fallback: 40))
                            .font(Font.system(size: __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].modifier[1].arg[0].value.arg[0].value", fallback: 20)))
                    }

                    Section(header: Text(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.arg[0].value", fallback: "Pick the date"))) {
                        HStack {
                            Picker(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].arg[0].value", fallback: "Month"), selection: $selectedMonth) {
                                ForEach(__designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].arg[2].value.[0].arg[0].value.[0]", fallback: 1) ..< months.count + __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].arg[2].value.[0].arg[0].value.[1]", fallback: 1), id: \.self) { index in
                                    Text("\(months[index - __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].arg[2].value.[0].arg[2].value.[0].arg[0].value.[1].value.arg[0].value.[0].value.[0]", fallback: 1)])").tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].modifier[1].arg[0].value", fallback: 150))

                            Picker(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[1].arg[0].value", fallback: "Day"), selection: $selectedDay) {
                                ForEach(days, id: \.self) { day in
                                    Text("\(day)").tag(day)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[1].modifier[1].arg[0].value", fallback: 60))

                            Picker(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[2].arg[0].value", fallback: "Select a Year"), selection: $selectedYear) {
                                ForEach(years, id: \.self) { year in
                                    Text(year).tag(year)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .labelsHidden()
                            .frame(height: __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].arg[0].value.[2].modifier[2].arg[0].value", fallback: 120))
                        }
                    }

                    Section(header: Text(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[0].value.arg[0].value", fallback: "Notes"))) {
                        TextField(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[1].value.[0].arg[0].value", fallback: "Any additional information"), text: $note)
                            .frame(height: __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[1].value.[0].modifier[0].arg[0].value", fallback: 40))
                            .font(Font.system(size: __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[1].value.[0].modifier[1].arg[0].value.arg[0].value", fallback: 20)))
                    }

                    Section(header: Text(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.arg[0].value", fallback: "Remind me:"))) {
                        Toggle(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[0].arg[0].value", fallback: "On birthday at 10:00 AM"), isOn: $thatDayNotificationEnabled)
                        Toggle(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[1].arg[0].value", fallback: "1 day before"), isOn: $dayBeforeNotificationEnabled)
                        Toggle(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[2].arg[0].value", fallback: "1 week before"), isOn: $weekBeforeNotificationEnabled)
                    }
                    .frame(height: __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].modifier[0].arg[0].value", fallback: 40))
                }
                .navigationBarItems(
                    leading:
                        Button(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[0].value.arg[0].value", fallback: "Cancel")) {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundStyle(.orange),
                    trailing:
                        Button(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[1].value.arg[0].value", fallback: "Save")) {
                            let birthday = Birthday(
                                name: name,
                                year: __designTimeInteger("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[0].arg[1].value.arg[1].value.[0].value.arg[1].value", fallback: 2023),
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
                .navigationBarTitle(__designTimeString("#10420.[2].[14].property.[0].[0].arg[0].value.[0].arg[0].value.[0].modifier[1].arg[0].value", fallback: "New birthday"), displayMode: .large)
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    
#sourceLocation()
    }
}

extension BirthdayDetailsView {
    @_dynamicReplacement(for: days) private var __preview__days: [Int] {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/BirthdayDetailsView.swift", line: 41)
        switch selectedMonth {
        case 1:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[0].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[0].[0].arg[0].value.[1]", fallback: 31))
        case 2:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[1].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[1].[0].arg[0].value.[1]", fallback: 28))
        case 3:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[2].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[2].[0].arg[0].value.[1]", fallback: 31))
        case 4:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[3].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[3].[0].arg[0].value.[1]", fallback: 30))
        case 5:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[4].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[4].[0].arg[0].value.[1]", fallback: 31))
        case 6:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[5].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[5].[0].arg[0].value.[1]", fallback: 30))
        case 7:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[6].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[6].[0].arg[0].value.[1]", fallback: 31))
        case 8:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[7].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[7].[0].arg[0].value.[1]", fallback: 31))
        case 9:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[8].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[8].[0].arg[0].value.[1]", fallback: 30))
        case 10:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[9].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[9].[0].arg[0].value.[1]", fallback: 31))
        case 11:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[10].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[10].[0].arg[0].value.[1]", fallback: 30))
        case 12:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[11].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[11].[0].arg[0].value.[1]", fallback: 31))
        default:
            return Array(__designTimeInteger("#10420.[2].[12].property.[0].[0].[12].[0].arg[0].value.[0]", fallback: 1)...__designTimeInteger("#10420.[2].[12].property.[0].[0].[12].[0].arg[0].value.[1]", fallback: 31))
        }
    
#sourceLocation()
    }
}

extension BirthdayDetailsView {
    @_dynamicReplacement(for: buttonDisabled) private var __preview__buttonDisabled: Bool {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/BirthdayDetailsView.swift", line: 19)
        return name.isEmpty
    
#sourceLocation()
    }
}

import struct Birthdays.BirthdayDetailsView
#Preview {
    BirthdayDetailsView()
}



