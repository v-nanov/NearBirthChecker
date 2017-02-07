//
//  ScheduleViewer.swift
//  BabyChecker
//
//  Created by hoonhoon on 2017. 2. 5..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import UIKit
import RealmSwift

class AddButton: UIButton {
    var type: ScheduleType = .food
    override func title(for state: UIControlState) -> String? {
        return self.type.description
    }

}

class ScheduleViewer {

    weak var view: ViewController?
    var buttons: [UIButton] = []
    let trashItem: UIBarButtonItem

    var title: String? {
        set(value) {
            self.view?.navigationController?.title = value
            self.view?.title = value
        }
        get {
            return self.view?.navigationController?.title
        }
    }

    init(view aView: ViewController) {
        self.view = aView
        self.trashItem = UIBarButtonItem()
    }

    func setup() {

        self.view?.navigationController?.navigationBar.barStyle = .blackTranslucent

    }

    func addButtonEvent(target: Any?, action: Selector) {
        self.buttons.forEach { (btn) in
            btn.target(forAction: action, withSender: target)
        }
    }

    func addTrashEvent(target: AnyObject?, action: Selector) {
        self.trashItem.target = target
        self.trashItem.action = action
    }

    func addTimes(times: [Time]) {
        
    }

    func scrollBottom(animated: Bool = false) {
    }
}
