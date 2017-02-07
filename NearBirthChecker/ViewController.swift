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

    var type: ScheduleType = .food
    var presenter: SchedulePresenter?

    @IBOutlet weak var navigationBar: UINavigationBar?
    @IBOutlet weak var toolBar: UIToolbar?
    
    @IBOutlet weak var textView: UITextView?

    @IBOutlet var addItems: [UIBarButtonItem]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = SchedulePresenter(viewer: ScheduleViewer(view: self))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
