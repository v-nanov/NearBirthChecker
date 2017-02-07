//
//  DateUtils.swift
//  BabyChecker
//
//  Created by hoonhoon on 2017. 2. 8..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import Foundation

let DateSimpleFormat: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateFormat = "MM/dd HH시 mm분"
    return formatter
}()

protocol DateUtil {
    static func yearMonthDayDate(isEndDateOfToday: Bool) -> Date
    static func goodMorningDate() -> Date
    static func goodNightDate() -> Date
    func formattedString() -> String
}

extension DateUtil {
    static func yearMonthDayDate(isEndDateOfToday: Bool = false) -> Date {
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        if isEndDateOfToday {
            comps.hour = 24
            comps.second = -1
        }
        return Calendar.current.date(from: comps)!
    }
    static func goodMorningDate() -> Date {
        return yearMonthDayDate()
    }
    static func goodNightDate() -> Date {
        return yearMonthDayDate(isEndDateOfToday: true)
    }

    func formattedString() -> String {
        return DateSimpleFormat.string(from: self as? Date ?? Date())
    }
}

extension Date: DateUtil {}
extension NSDate: DateUtil {}
