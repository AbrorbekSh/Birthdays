//
//  CalendarView.swift
//  Birthdays
//
//  Created by Abrorbek Shanazarov on 23.11.2023.
//

import SwiftUI

struct CalendarView: UIViewRepresentable {
    let interval: DateInterval
    @ObservedObject var viewModel: BirthdaysViewModel
    @Binding var dateSelected: DateComponents?
    @Binding var displayBirthdays: Bool
    @StateObject var birthdaysViewModel = BirthdaysViewModel()
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        return view
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, viewModel: _viewModel)
    }

    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        var parent: CalendarView
        @ObservedObject var viewModel: BirthdaysViewModel
        
        init(parent: CalendarView, viewModel: ObservedObject <BirthdaysViewModel>) {
            self.parent = parent
            self._viewModel = viewModel
        }
        
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            let foundBirthdays = viewModel.birthdays
                .filter {
                    guard let birthdayDate = $0.date,
                          let comparisonDate = dateComponents.date else { return false }
                    
                    let calendar = Calendar.current
                    let comparisonDay = calendar.component(.day, from: comparisonDate)
                    let comparisonMonth = calendar.component(.month, from: comparisonDate)

                    return birthdayDate.day == comparisonDay && birthdayDate.month == comparisonMonth
                }
            
            if !foundBirthdays.isEmpty {
                return .image(UIImage(systemName: "circle.fill"), color: .systemOrange, size: .large)
            }
            
            return nil
        }
        
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.dateSelected = dateComponents
            guard let dateComponents else { return }
            let foundBirthdays = viewModel.birthdays
                .filter {
                    guard let birthdayDate = $0.date,
                          let comparisonDate = dateComponents.date else { return false }
                    
                    let calendar = Calendar.current
                    let comparisonDay = calendar.component(.day, from: comparisonDate)
                    let comparisonMonth = calendar.component(.month, from: comparisonDate)

                    return birthdayDate.day == comparisonDay && birthdayDate.month == comparisonMonth
                }
            if !foundBirthdays.isEmpty {
                parent.displayBirthdays.toggle()
            }
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
            return true
        }
    }
}
