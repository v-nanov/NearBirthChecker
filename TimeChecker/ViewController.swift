//
//  ViewController.swift
//  BabyChecker
//
//  Created by hoonhoon on 2017. 2. 5..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, Identifierable {

    var presenter: SchedulePresenter?
    
    @IBOutlet weak var textView: UITextView?

    @IBOutlet weak var trashItem: UIBarButtonItem!
    @IBOutlet weak var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = SchedulePresenter(viewer: ScheduleViewer(view: self))
        self.presenter?.viewer.setup()
        self.presenter?.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
