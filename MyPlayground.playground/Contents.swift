//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var formatter = DateFormatter()
formatter.dateFormat = "MM/dd HH시 mm분"

let date = Date()
formatter.string(from: date)