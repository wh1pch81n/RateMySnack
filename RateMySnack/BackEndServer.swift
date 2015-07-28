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
    
    
 
    
    static func submit(item: FormObject, completionHandler completion: ((err: NSError?) -> Void)) {
        var snack:PFObject = PFObject(className: "AllSnacks")
        snack["SnackName"] = item.snackName
        
        snack.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error == nil {
                println(success)
            } else {
                println(error)
            }
            completion(err: error)
        }
    }
    
    static func retrieve(requestCompleted request: ((err: NSError?, objs: [FormObject]) -> Void)) {
        
        var findSnacks:PFQuery = PFQuery(className: "AllSnacks")
       // findSnacks.whereKey("objectId", containsString: "SnackName")
        findSnacks.includeKey("objectId")
        
//        findSnacks.getFirstObjectInBackgroundWithBlock { (objects: PFObject?, error: NSError?) -> Void in
//            if error == nil{
//                println(objects)
//            }
//        }
        
        findSnacks.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            var nameOfSnack: [FormObject] = []
            if error == nil{
             //   request(err: nil, objs: objects)
                
                if let objs = objects {
                    //Querying everything inside of the class but only displaying the 1st(0) String
                    //println(objs[0]["SnackName"])
                    for i in objs {
                        var fo = Snack(name: i["SnackName"] as! String)
                        nameOfSnack.append(fo)
                    }
                    
                    request(err: nil, objs: nameOfSnack)
                    //println(nameOfSnack)
                }
//                println(objects)
            }
        }
    
    
}
    
    
}
