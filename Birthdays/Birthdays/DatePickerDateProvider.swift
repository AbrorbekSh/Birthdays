////
////  DatePickerDateProvider.swift
////  Birthdays
////
////  Created by Abrorbek Shanazarov on 02.01.2024.
////
//
//import Foundation
//
//final class DatePickerDateProvider {
//    static let shared = DatePickerDateProvider()
//
//    private init() {}
//
//    let months = [
//        "January",
//        "February",
//        "March",
//        "April",
//        "May",
//        "June",
//        "July",
//        "August",
//        "September",
//        "October",
//        "November",
//        "December"
//    ]
//
//    var days: [Int] {
//        switch selectedMonth {
//        case 1:
//            return Array(1...31)
//        case 2:
//            return Array(1...28)
//        case 3:
//            return Array(1...31)
//        case 4:
//            return Array(1...30)
//        case 5:
//            return Array(1...31)
//        case 6:
//            return Array(1...30)
//        case 7:
//            return Array(1...31)
//        case 8:
//            return Array(1...31)
//        case 9:
//            return Array(1...30)
//        case 10:
//            return Array(1...31)
//        case 11:
//            return Array(1...30)
//        case 12:
//            return Array(1...31)
//        default:
//            return Array(1...31)
//        }
//    }
//
//    let years: [String] = (1940...2023).map { String($0) } + ["----"]
//}
