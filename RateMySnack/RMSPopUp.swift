//
//  RMSPopUp.swift
//  RateMySnack
//
//  Created by S. Han on 9/20/15.
//  Copyright © 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import UIKit

func successPopUpOn(vc: UIViewController, complete: () -> ()) {
    let alart = UIAlertController(title: "Successful!",
        message: "Successfully submitted Snack for review.",
        preferredStyle: UIAlertControllerStyle.Alert)
    
    let okAction = UIAlertAction(title: "OK",
        style: UIAlertActionStyle.Default,
        handler: nil)
    alart.addAction(okAction)
    vc.presentViewController(alart, animated: true, completion: complete)
}

func failPopUpOn(vc: UIViewController, complete: () -> ()) {
    let alart = UIAlertController(title: "Ops!",
        message: "There was a problem processing your snack. Please try again later.",
        preferredStyle: UIAlertControllerStyle.Alert)
    
    let okAction = UIAlertAction(title: "OK",
        style: UIAlertActionStyle.Default,
        handler: nil)
    alart.addAction(okAction)
    vc.presentViewController(alart, animated: true, completion: complete)
}

func duplicationPopUpOn(vc: UIViewController, complete: () -> ()) {
    let alart = UIAlertController(title: "Ops!",
        message: "This snack already exists.",
        preferredStyle: UIAlertControllerStyle.Alert)
    
    let okAction = UIAlertAction(title: "OK",
        style: UIAlertActionStyle.Default,
        handler: nil)
    alart.addAction(okAction)
    vc.presentViewController(alart, animated: true, completion: complete)
}