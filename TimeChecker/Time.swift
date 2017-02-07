//
//  Time.swift
//  NearBirthChecker
//
//  Created by hoonhoon on 2017. 1. 30..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import Foundation
import RealmSwift

class Time: Object {

    var type: ScheduleType {
        set {
            self.typeNum = newValue.rawValue
        }
        get {
            return ScheduleType(rawValue: self.typeNum)!
        }
    }

    dynamic var typeNum: Int = 0
    dynamic var start: NSDate = .init()
    dynamic var end: NSDate? = nil

    override static func ignoredProperties() -> [String] {
        return ["type"]
    }

    var progressing: Bool {
        return nil == end
    }
}
