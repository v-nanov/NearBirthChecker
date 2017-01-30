//
//  ViewController.swift
//  NearBirthChecker
//
//  Created by hoonhoon on 2017. 1. 30..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {

    enum TimeState {
        case needStart
        case needEnd
    }

    var startItems: [UIBarButtonItem]?
    var endItems: [UIBarButtonItem]?

    var startItem: UIBarButtonItem!
    var endItem: UIBarButtonItem!

    var timesToken: NotificationToken?
    var times: Results<Time>?

    var timeState: TimeState {
        guard let last = self.times?.last else {
            self.setToolbarItems(self.startItems, animated: true)
            return .needStart
        }
        if last.end == nil {
            self.setToolbarItems(self.endItems, animated: true)
            return .needEnd
        } else {
            self.setToolbarItems(self.startItems, animated: true)
            return .needStart
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.startItems = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                           UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(toggle(_:))),
                           UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)]
        self.endItems = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                           UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(toggle(_:))),
                           UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)]

        guard let realm = try? Realm() else { return }
        self.times = realm.objects(Time.self).sorted(byKeyPath: "start")
        self.timesToken = self.times?.addNotificationBlock({
            [weak self] (change) in
            self?.tableView.reloadData()
            let _ = self?.timeState
        })
        let _ = self.timeState
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0 < (self.times?.count ?? 0) ? 1 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.times?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath)
        if let timeCell = cell as? TimeCell {
            timeCell.time = self.times?[indexPath.row]
        }
        return cell
    }

    @IBAction func toggle(_ sender: UIBarButtonItem) {
        guard let realm = try? Realm() else { return }

        switch self.timeState {
        case .needStart:
            let time = Time()
            time.start = NSDate()
            try? realm.write {
                realm.add(time)
            }
        case .needEnd:
            if let last = self.times?.last {
                try? realm.write {
                    last.end = NSDate()
                }
                return
            }
        }

    }
    
    @IBAction func clear(_ sender: Any) {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            [weak self] in
            guard (self?.times?.count ?? 0) > 0, let times = self?.times else { return }
            realm.delete(times)
        }
    }
    
}

