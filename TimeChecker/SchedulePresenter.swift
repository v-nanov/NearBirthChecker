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

    var results: Results<Time>?
    var notificationToken: NotificationToken?
    var viewer: ScheduleViewer
    var type: ScheduleType = .food {
        didSet {
            self.viewer.title = type.description
            let realm = try! Realm()
            self.results = realm.objects(Time.self).filter(NSPredicate(format: "self.typeNum == %d", argumentArray: [type.rawValue])).sorted(byKeyPath: "start")
            self.notificationToken = self.results?.addNotificationBlock(self.callback)
            self.loadSchedules()
        }
    }

    init(viewer: ScheduleViewer) {
        self.viewer = viewer
    }

    func setup() {
        self.viewer.title = self.type.description
        self.viewer.addButtonEvent(target: self, action: #selector(self.addEvent(sender:)))
        self.viewer.addTrashEvent(target: self, action: #selector(self.clearEvent(sender:)))
        self.loadSchedules()
    }

    func loadSchedules() {
        self.viewer.text = self.schedulesText(fromResults: self.results)
        self.viewer.scrollBottom()
    }

    func callback(change: RealmCollectionChange<Results<Time>>) {
        switch change {
        case .initial(let times), .update(let times, _, _, _):
            self.viewer.text = self.schedulesText(fromResults: times)
            if let last = times.last {
                self.viewer.scrollBottom(animated: last.end == nil)
            }
        default:
            break
        }
    }

    func schedulesText(fromResults results: Results<Time>?) -> String {
        guard let results = results, results.count > 0 else { return "" }

        return results.reduce("", { (prev, time) -> String in
            var times = "\(prev)\n\(time.start.formattedString())"
            if let end = time.end {
                times += "-\(end.formattedString())"
            }
            return times
        })
    }

    func addTime() -> Time? {
        let realm = try! Realm()
        let times = realm.objects(Time.self).sorted(byKeyPath: "start")
        var currentTime = times.last
        var write: () throws -> Void
        if currentTime == nil || currentTime?.end != nil {
            let time = Time()
            time.start = NSDate()
            time.type = self.type
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
        let _ = self.addTime()
    }
    @objc func clearEvent(sender: Any!) {
        self.clear()
    }
}
