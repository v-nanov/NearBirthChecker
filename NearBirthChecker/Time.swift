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

    dynamic var parentSchedule: Schedule?

    dynamic var start: NSDate = .init()
    dynamic var end: NSDate? = nil

    var progressing: Bool {
        return nil == end
    }
}
