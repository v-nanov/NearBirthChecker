//
//  SchedulePresenter.swift
//  BabyChecker
//
//  Created by hoonhoon on 2017. 2. 5..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import Foundation
import RealmSwift

enum ScheduleType: Int, CustomStringConvertible {
    case food   // 밥
    case huggies // 기저귀

    var description: String {
        switch self {
        case .food:
            return "밥"
        case .huggies:
            return "기저귀"
        }
    }
}

class SchedulePresenter {

    let results: Results<Time>
    var notificationToken: NotificationToken?
    var viewer: ScheduleViewer

    init(viewer: ScheduleViewer) {
        self.viewer = viewer
        let realm = try! Realm()
        self.results = realm.objects(Time.self).sorted(byKeyPath: "start")
    }

    deinit {
        notificationToken?.stop()
    }

    func setup() {
        self.viewer.title = "TimeChecker"
        self.viewer.addButtonEvent(target: self, action: #selector(self.addEvent(sender:)))
        self.viewer.addTrashEvent(target: self, action: #selector(self.clearEvent(sender:)))
        self.notificationToken = self.results.addNotificationBlock(self.callback)
        self.loadSchedules()
    }

    func loadSchedules() {
        var times: [Time] = []
        for time in self.results {
            times.append(time)
        }
        self.viewer.addTimes(times: times)
    }

    func callback(change: RealmCollectionChange<Results<Time>>) {
        switch change {
        case .initial(let times), .update(let times, _, _, _):
            break
        default:
            break
        }
    }

    func addTime(type: ScheduleType) -> Time? {
        let realm = try! Realm()
        let times = realm.objects(Time.self).sorted(byKeyPath: "start")
        var currentTime = times.last
        var write: () throws -> Void
        if currentTime == nil || currentTime?.end != nil {
            let time = Time()
            time.start = NSDate()
            time.type = type
            write = {
                realm.add(time)
            }
            currentTime = time
        } else {
            write = {
                currentTime?.end = NSDate()
            }
        }
        try! realm.write(write)
        return currentTime
    }

    func clear() {
        let r = try! Realm()
        let times = r.objects(Time.self)
        try! r.write {
            r.delete(times)
        }
    }

    @objc func addEvent(sender: Any!) {
        let _ = self.addTime(type: .food)
    }
    @objc func clearEvent(sender: Any!) {
        self.clear()
    }
}
