//
//  ScheduleViewer.swift
//  BabyChecker
//
//  Created by hoonhoon on 2017. 2. 5..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import UIKit
import RealmSwift

class ScheduleViewer {

    weak var view: ViewController?

    var title: String? {
        set(value) {
            self.view?.navigationController?.title = value
            self.view?.title = value
        }
        get {
            return self.view?.navigationController?.title
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

    func setup() {
        self.view?.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.view?.textView?.isEditable = false
    }

    func addButtonEvent(target: Any?, action: Selector) {
        self.view?.addButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func addTrashEvent(target: AnyObject?, action: Selector) {
        self.view?.trashItem.target = target
        self.view?.trashItem.action = action
    }

    func scrollBottom(animated: Bool = false) {
        var scrollRect: CGRect = self.view?.textView?.bounds ?? .init()
        let contentSize: CGSize = self.view?.textView?.contentSize ?? .init()
        var visibleHeight: CGFloat = scrollRect.height
        guard visibleHeight < contentSize.height else { return }
        scrollRect.origin.x = 0
        scrollRect.origin.y = contentSize.height - scrollRect.height
        self.view?.textView?.scrollRectToVisible(scrollRect, animated: animated)
    }
}
