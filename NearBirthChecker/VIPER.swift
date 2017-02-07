//
//  Viewer.swift
//  BabyChecker
//
//  Created by hoonhoon on 2017. 2. 5..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import UIKit

protocol VIPERView {
    associatedtype Presenter = VIPERPresenter

    var presenter: Presenter { get set }
}

protocol VIPERPresenter {
    associatedtype View = VIPERView
    associatedtype Interactor = VIPERInteractor

    var view: View { get set }
    var interactor: Interactor { get set }
}

protocol VIPERInteractor {

}

protocol VIPEREntity {

}

protocol VIPERRouter {
    
}
