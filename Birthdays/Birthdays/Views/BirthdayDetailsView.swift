import SwiftUI
import SwiftData

enum BirthdayDetailsViewType {
    case new
    case edit
}

struct BirthdayDetailsView: View {
    @StateObject var viewModel: BirthdayDetailsViewModel
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter the name")) {
                    TextField("Name", text: $viewModel.name)
                        .frame(height: 40)
                        .font(Font.system(size: 20))
                        .autocorrectionDisabled()
                }

                Section(header: Text("Pick the date")) {
                    HStack {
                        Picker("Day", selection: $viewModel.selectedDay) {
                            ForEach(viewModel.daysInSelectedMonth, id: \.self) { day in
                                Text("\(day)").tag(day)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 60)

                        Picker("Month", selection: $viewModel.selectedMonth) {
                            ForEach(1..<viewModel.months.count + 1, id: \.self) { index in
                                Text(viewModel.months[index - 1]).tag(index)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 150)

                        Picker("Select a Year", selection: $viewModel.selectedYear) {
                            ForEach(viewModel.years, id: \.self) { year in
                                Text(year).tag(year)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .labelsHidden()
                        .frame(height: 120)
                    }
                }

                Section(header: Text("Notes")) {
                    TextField("Any additional information", text: $viewModel.note)
                        .frame(height: 40)
                        .font(Font.system(size: 20))
                        .autocorrectionDisabled()
                }

                Section(header: Text("Remind me")) {
                    Toggle("On birthday at 10:00 AM", isOn: $viewModel.thatDayNotificationEnabled)
                    Toggle("1 day before", isOn: $viewModel.dayBeforeNotificationEnabled)
                    Toggle("1 week before", isOn: $viewModel.weekBeforeNotificationEnabled)
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
                        viewModel.saveBirthday {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .foregroundStyle(.orange)
                    .disabled(viewModel.name.isEmpty)
            )
            .navigationBarTitle(viewModel.title, displayMode: .large)
        }
        .navigationBarHidden(true)
    }
}

