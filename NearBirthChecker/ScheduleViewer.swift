//
//  ScheduleViewer.swift
//  BabyChecker
//
//  Created by hoonhoon on 2017. 2. 5..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import RealmSwift

class ScheduleViewer {

    weak var view: ViewController?

    var title: String? {
        set(value) {
            self.view?.navigationBar?.topItem?.title = value
        }
        get {
            return self.view?.navigationBar?.topItem?.title
        }
    }

    var text: String? {
        set(value) {
            self.view?.textView?.text = value
        }
        get {
            return self.view?.textView?.text
        }
    }

    init(view aView: ViewController) {
        self.view = aView
    }

}
