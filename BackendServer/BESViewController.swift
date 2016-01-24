//
//  ViewController.swift
//  BackendServer
//
//  Created by Derrick  Ho on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

class BESViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        var s = Snack(name: "", description: "")
//        s.objectId = "gppjXFzUQg"
//        BESInterface.getRatingOfSnack(s) { (rating, err) -> () in
//            if err != nil {
//                
//            }
//            print(rating)
//        }
		BackendDelegate_SharedInstance().retrieve { (objs, err) -> Void in
			print(objs)
			let start = (objs.count - 10) > 0 ? objs.count - 10 : 0
			let end = objs.count
			objs[start..<end].forEach({ (obj) -> () in
				let group = dispatch_group_create()
				dispatch_group_enter(group)
				obj.1({ (rating: UInt, err: RMSBackendError?) ->() in
					print(obj.0.snackName, rating)
					dispatch_group_leave(group)
				})
				dispatch_group_wait(group,
					dispatch_time(
						DISPATCH_TIME_NOW,
						Int64(5 * 60 * NSEC_PER_SEC)))
			})
		}
    }
}

