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

class FormTest: FormObject {
    var snackName:String = "Kitkat"
}

class BackEndServer: BackendDelegate {
    
    static func submit(item:FormObject, completionHandler completion:((NSError) -> Void)) {
        var snack:PFObject = PFObject(className: "AllSnacks")
        snack["SnackName"] = item.snackName
        
        snack.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error == nil{
                println(success)
            }else {
                println(error)
            }
             completion(error!)
        }
        
    }
    
    static func retrieve(requestCompleted request:((NSError, [FormObject]) -> Void)) {
        
        
    }

}
