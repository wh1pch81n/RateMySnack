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
        
        <#Does the snack name ready exist?#>
        <#add logic such that it will only submit if the snack name doesn't already exist#>
        
        // Creates an instance of AllSnack Object
        var snack:PFObject = PFObject(className: "AllSnacks")
        
        // sets the SnackName property based on the item name
        snack["SnackName"] = item.name
    
        // Save new snack in background asynhronously
        snack.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            // When the save finishes call the completion block
            completion(err: error)
        }
    }
    
    static func retrieve(requestCompleted request: ((err: NSError?, objs: [SnackProtocol]) -> Void)) {
        
        var findSnacks:PFQuery = PFQuery(className: "AllSnacks")
        findSnacks.includeKey("objectId")
        
        findSnacks.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            var nameOfSnack: [SnackProtocol] = []
            if error == nil{
                if let objs = objects {
                    for i in objs {
                        var fo = Snack(name: i["SnackName"] as! String, description: "")
                        nameOfSnack.append(fo)
                    }
                    request(err: error, objs: nameOfSnack)
                }
            }
        }
    }
    
    private static func hasSnackNamed(snackName: String, withClassName name: String = "AllSnacks") -> Bool {
        // Make Query "AllSnacks"
        var queryAllSnack = PFQuery(className: "AllSnacks")
        
        // Refine queryAllSnack query to include all with the specified snameName
        <#Implement me!#>
        
        // Begin the query and perform it it synchronously
        var err : NSError?
        var objectsThatMatch : [AnyObject]? = queryAllSnack.findObjects(&err)
        
        if err == nil {
            // If objectsThatMatch is empty then return false otherwise return true
            <#Implement me!#>
        }
        
        return <#Implement Me!#>
    }
    
}
