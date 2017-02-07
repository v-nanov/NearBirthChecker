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

let HHmmssDateFormat: DateFormatter = {
    var formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = "HH시 mm분 ss초"
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

    func HHmmSSFormattedString() -> String {
        return ""
    }
}

extension DateUtil where Self: DateCalculatable {
    func HHmmSSFormattedString() -> String {
        var formattedString: String = ""
        var times: Int64 = Int64(self.timeIntervalSince1970)
        let seconds = times % 60
        formattedString = "\(seconds)초"
        times -= seconds
        times = times / 60
        let minutes = times % 60
        if minutes > 0 {
            formattedString = "\(minutes)분" + (formattedString.characters.count > 0 ? " \(formattedString)" : "")
            times -= minutes
        }
        times = times / 60
        let hours = times
        if hours > 0 {
            formattedString = "\(hours)시간" + (formattedString.characters.count > 0 ? " \(formattedString)" : "")
        }
        
        return formattedString
    }
}

extension Date: DateUtil {}
extension NSDate: DateUtil {}

protocol DateCalculatable {

    init(timeIntervalSince1970: TimeInterval)
    var timeIntervalSince1970: TimeInterval { get }

}

extension Date: DateCalculatable {}
extension NSDate: DateCalculatable {}

func -<D: DateCalculatable>(lhs: D, rhs: D) -> D {
    return D(timeIntervalSince1970: lhs.timeIntervalSince1970 - rhs.timeIntervalSince1970)
}
