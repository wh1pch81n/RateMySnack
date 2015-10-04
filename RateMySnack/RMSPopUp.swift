//
//  RMSPopUp.swift
//  RateMySnack
//
//  Created by S. Han on 9/20/15.
//  Copyright © 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import UIKit

func successPopUpOn(vc: UIViewController, didDismiss block: (UIAlertAction) -> ()) {
    let alart = UIAlertController(title: "Successful!",
        message: "Successfully submitted Snack for review.",
        preferredStyle: UIAlertControllerStyle.Alert)
    
    let okAction = UIAlertAction(title: "OK",
        style: UIAlertActionStyle.Default,
        handler: block)
    alart.addAction(okAction)
    vc.presentViewController(alart, animated: true, completion: nil)
}

func failPopUpOn(vc: UIViewController, didDismiss block: (UIAlertAction) -> ()) {
    let alart = UIAlertController(title: "Oops!",
        message: "There was a problem processing your snack. Please try again later.",
        preferredStyle: UIAlertControllerStyle.Alert)
    
    let okAction = UIAlertAction(title: "OK",
        style: UIAlertActionStyle.Default,
        handler: block)
    alart.addAction(okAction)
    vc.presentViewController(alart, animated: true, completion: nil)
}

func duplicationPopUpOn(vc: UIViewController, didDismiss block: (UIAlertAction) -> ()) {
    let alart = UIAlertController(title: "Oops!",
        message: "This snack already exists.",
        preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction(title: "OK",
        style: UIAlertActionStyle.Default,
        handler: block)
    alart.addAction(okAction)
    vc.presentViewController(alart, animated: true, completion: nil)
}

func incompleteSnackFormPopUpOn(vc: UIViewController, withError err:RMSSubmissionFormError, didDismiss block: (UIAlertAction) -> ()) {
    
    var alertMessage: String = ""
    if err == RMSSubmissionFormError.SnackDescription {
        alertMessage = "Please fill out the snack description"
    } else if err == RMSSubmissionFormError.SnackName {
        alertMessage = "Please enter a valid snack name"
    }
    
    let messageAlert = UIAlertController(title: "oops!",
        message: alertMessage,
        preferredStyle: UIAlertControllerStyle.Alert)
        
    let okAction = UIAlertAction(title: "OK",
        style: UIAlertActionStyle.Default,
        handler: block)
    messageAlert.addAction(okAction)
    vc.presentViewController(messageAlert, animated: true, completion: nil)
}