//
//  Schedule.swift
//  BabyChecker
//
//  Created by hoonhoon on 2017. 2. 5..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import Foundation
import RealmSwift

class Schedule: Object {

    var type: ScheduleType {
        get {
            return ScheduleType(rawValue: self.typeNum)!
        }
        set {
            self.typeNum = newValue.rawValue
        }
    }

    dynamic var typeNum: Int = 0

    let times: List<Time> = List<Time>()

}
