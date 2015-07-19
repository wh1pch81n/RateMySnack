//
//  BackendServerTest.swift
//  RateMySnack
//
//  Created by S. Han on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import XCTest
import RateMySnack
import Parse

class BackendServerTest: XCTestCase {

    override func setUp() {
        super.setUp()
        Parse.setApplicationId("r7EqA8YMRx0ew2OaE2ebKZnErKWdJgmR1hBtQBAQ",
            clientKey: "tIWDqmLYrdcquuzznkZS9iJ5CqX8ieOYZhhT4bnz")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSubmit() {
        var item: FormObject = FormTest()
        BackEndServer.submit(item, completionHandler:{ (NSError) -> Void in
            println("done")
        })
    }

}
