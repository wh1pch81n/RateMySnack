//
//  AppDelegate.swift
//  RateMySnack
//
//  Created by Ho, Derrick on 7/10/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId("r7EqA8YMRx0ew2OaE2ebKZnErKWdJgmR1hBtQBAQ", clientKey: "tIWDqmLYrdcquuzznkZS9iJ5CqX8ieOYZhhT4bnz")
        return true
	}

	func applicationWillResignActive(application: UIApplication) {
    }

	func applicationDidEnterBackground(application: UIApplication) {
    }
    
	func applicationWillEnterForeground(application: UIApplication) {
	}

	func applicationDidBecomeActive(application: UIApplication) {
	}

	func applicationWillTerminate(application: UIApplication) {
	}
    
}

