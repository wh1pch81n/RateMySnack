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
        if BackEndServer.hasSnackNamed(item.name) {
            completion(err: NSError(domain: .Backend, code: RMSBackendError.Duplication.rawValue))
            return
        }
        // Creates an instance of AllSnack Object
        var snack = PFObject.AllSnackObject()
        // sets the SnackName property based on the item name
        snack[.SnackName] = item.name
        // Save new snack in background asynhronously
        snack.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            // When the save finishes call the completion block
            if (success) {
                completion(err: nil)
                return
            }
            if error?.code == PFErrorCode.ErrorTimeout.rawValue {
                completion(err: NSError(domain: .Backend, code: RMSBackendError.Timeout.rawValue))
                return
            }
            completion(err: NSError(domain: .Backend, code: RMSBackendError.UnexpectedNetworkError.rawValue)) //Lost coonnection
        }
    }
    
    static func retrieve(requestCompleted request: ((err: NSError?, objs: [SnackProtocol]) -> Void)) {
        
        var findSnacks = PFQuery(className: AllSnacksKeys.AllSnacks.rawValue)
        findSnacks.includeKey(ParseObjectKeys.ObjectId.rawValue)
        
        findSnacks.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            var nameOfSnack: [SnackProtocol] = []
            if error == nil {
                if let objs = objects as! [AllSnacks]? {
                    for i in objs {
                        var fo = Snack(name: i[.SnackName] as! String, description: "")
                        nameOfSnack.append(fo)
                    }
                    request(err: error, objs: nameOfSnack)
                }
            }
        }
    }
    
    private static func hasSnackNamed(snackName: String, withClassName name: String = AllSnacksKeys.AllSnacks.rawValue) -> Bool {
        // Make Query "AllSnacks"
        var queryAllSnack = PFQuery(className: name) //1.querying for objects with the class name "AllSnacks"
        
        // Refine queryAllSnack query to include all with the specified snameName
        
        queryAllSnack.whereKey(AllSnacksKeys.SnackName.rawValue, equalTo: snackName) //2.Key = colum ; equalTo <the input of data>
        queryAllSnack.selectKeys([AllSnacksKeys.SnackName.rawValue]) //3.Only pulling data from the specified key
        queryAllSnack.limit = 1 //4.setting a limit of returning of the same snack as 1
        
        // Begin the query and perform it it synchronously
        var err : NSError?
        var objectsThatMatch : [AnyObject]? = queryAllSnack.findObjects(&err) //TODO:you can actually simplied this line of code with countObject
        objectsThatMatch?.count
        if err == nil  {
            // If objectsThatMatch is empty then return false otherwise return true
            if let objectsThatMatch2 = objectsThatMatch {
                if objectsThatMatch2.count == 0 {
                    return false
                }
            }
        }
        
        return true
    }
    
}
