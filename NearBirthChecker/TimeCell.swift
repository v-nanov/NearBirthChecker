//
//  TimeCell.swift
//  NearBirthChecker
//
//  Created by hoonhoon on 2017. 1. 30..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import UIKit
import RealmSwift

class TimeCell: UITableViewCell {

    var dateFormatter: DateFormatter!

    var time: Time? {
        didSet {
            if let start = time?.start {
                self.startlabel.text = dateFormatter.string(from: start as Date)
            } else {
                self.startlabel.text = nil
            }
            if let end = time?.end {
                self.endlabel.text = dateFormatter.string(from: end as Date)
            } else {
                self.endlabel.text = nil
            }
        }
    }

    @IBOutlet weak var startlabel: UILabel!
    @IBOutlet weak var endlabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = .short
    }

}
