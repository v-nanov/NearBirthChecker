//
//  AppDelegate.swift
//  NearBirthChecker
//
//  Created by hoonhoon on 2017. 1. 30..
//  Copyright © 2017년 hoonhoon. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var config: Realm.Configuration?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.config = Realm.Configuration(schemaVersion: 2)

        if let tab = self.window?.rootViewController as? UITabBarController {
            let foodView = tab.storyboard?.instantiateViewController(withIdentifier: ViewController.Identifier) as! ViewController
            let huggiesView = tab.storyboard?.instantiateViewController(withIdentifier: ViewController.Identifier) as! ViewController
            foodView.presenter?.type = .food
            huggiesView.presenter?.type = .huggies
            tab.setViewControllers([foodView, huggiesView], animated: false)
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

