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

    let results: Results<Schedule>
    var notificationToken: NotificationToken?
    var viewer: ScheduleViewer
    var type: ScheduleType = .food {
        didSet(value) {
            self.viewer.title = value.description
        }
    }

    init(viewer: ScheduleViewer) {
        self.viewer = viewer
        let realm = try! Realm()
        self.results = realm.objects(Schedule.self)
        self.notificationToken = self.results.addNotificationBlock(self.callback)
        self.viewer.view?.addItems.forEach {
            [weak self] in
            guard let weakSelf = self else { return }
            $0.target = weakSelf
            $0.action = #selector(weakSelf.addTime)
        }
        self.loadSchedules()
    }

    func loadSchedules() {
        self.viewer.text = ""
    }

    func callback(change: RealmCollectionChange<Results<Schedule>>) {
        switch change {
        case .initial(let schedules), .update(let schedules, _, _, _):
            self.viewer.text = self.schedulesText(fromResults: schedules)
        default:
            break
        }
    }

    func schedulesText(fromResults results: Results<Schedule>) -> String {
        return results.reduce("", { (prevText, schedule) -> String in
            return prevText + "\n <\(schedule.type)>\n" + schedule.times.reduce("", { (prevTimeText, time) -> String in
                var text = prevText + "\n \(time.start)"
                if let end: NSDate = time.end {
                    text += end.description
                }
                return text
            }) + "\n"
        })
    }

    @objc func addTime() {
        
    }
}
