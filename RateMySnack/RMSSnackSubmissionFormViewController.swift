//
//  RMSSnackSubmissionFormViewController.swift
//  RateMySnack
//
//  Created by Maria Lopez on 9/11/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import UIKit

class RMSSnackSubmissionFormViewController: UIViewController {
    
    @IBOutlet var snackNameEntry: UITextField!
    
    @IBOutlet var snackDescription: UITextView!
    

   func cancelButton(sender: UIButton) {
    //    self.dismissViewControllerAnimated(true, completion: nil)
        
   }
    
    
    @IBOutlet var submitButton: UIButton!
    

    override func viewDidLoad() {
        submitButton.layer.borderColor = UIColor.grayColor().CGColor
        submitButton.layer.borderWidth = 3
        submitButton.layer.cornerRadius = 12.0
        
    }
}

