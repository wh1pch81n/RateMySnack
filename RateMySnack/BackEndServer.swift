//
//  BackEndServer.swift
//  RateMySnack
//
//  Created by S. Han on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import Parse
import Bolts

class BackEndServer: BackendDelegate {
    
    static func submit(item: SnackProtocol, completionHandler completion: ((err: NSError?) -> Void)) {
        var snack:PFObject = PFObject(className: "AllSnacks")
        snack["SnackName"] = item.name
        
        snack.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error == nil {
                println(success)
            } else {
                println(error)
            }
            completion(err: error)
        }
    }
    
    static func retrieve(requestCompleted request: ((err: NSError?, objs: [SnackProtocol]) -> Void)) {
        
    }

}
