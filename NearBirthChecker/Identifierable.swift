//
//  Identifierable.swift
//  BabyChecker
//
//  Created by hoonhoon on 2017. 2. 5..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import Foundation

protocol Identifierable {

    static var Identifier: String { get }

}

extension Identifierable {
    static var Identifier: String {
        return String(describing: self)
    }
}
