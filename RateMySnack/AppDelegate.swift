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
        Parse.setApplicationId(PARSE_APPLICATION_ID_KEY, clientKey: PARSE_CLIENT_KEY)
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

