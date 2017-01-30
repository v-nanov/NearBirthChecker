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

    @IBOutlet weak var startStopButton: UIBarButtonItem!
    var timesToken: NotificationToken?
    var times: Results<Time>?
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let realm = try? Realm() else { return }
        self.times = realm.objects(Time.self).sorted(byKeyPath: "start")
        self.timesToken = self.times?.addNotificationBlock({ (change) in
            self.tableView.reloadData()
        })
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

    @IBAction func start(_ sender: Any) {
        guard let realm = try? Realm() else { return }
        let time = Time()
        time.start = NSDate()
        try? realm.write {
            realm.add(time)
        }
    }

    @IBAction func end(_ sender: Any) {
        guard let realm = try? Realm() else { return }
        guard let lastTime: Time = times?.last else { return }
        try? realm.write {
            lastTime.end = NSDate()
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

