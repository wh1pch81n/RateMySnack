//
//  RMSStarViewController.swift
//  RateMySnack
//
//  Created by Maria Lopez on 8/29/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import UIKit

class RMSStarViewController: UIViewController {
    @IBOutlet weak var starZero: RMSStarView!
    @IBOutlet weak var starOne: RMSStarView!
    @IBOutlet weak var starTwo: RMSStarView!
    @IBOutlet weak var starThree: RMSStarView!
    @IBOutlet weak var starFour: RMSStarView!
	var starRating: Int = 0
    /**
    Turns the stars on or off depending on which star was tapped by the user
    
    :param: buttonThatWasJustClicked a reference to the UIButton that sent a message to the target
    */
    @IBAction func tappedStar(buttonThatWasJustClicked: UIButton) {
        let tag = buttonThatWasJustClicked.tag
        var starSettings: (Bool, Bool, Bool, Bool, Bool) = (false, false, false, false, false)
        
        if tag == 1 {
            starSettings = (true, false, false, false, false)
			starRating = tag
        }
        if tag == 2 {
            starSettings = (true, true, false, false, false)
			starRating = tag
        }
        if tag == 3 {
            starSettings = (true, true, true, false, false)
			starRating = tag
        }
        if tag == 4 {
            starSettings = (true, true, true, true, false)
			starRating = tag
        }
        if tag == 5 {
            starSettings = (true, true, true, true, true)
			starRating = tag
        }
        
        (starZero.enabled, starOne.enabled, starTwo.enabled, starThree.enabled, starFour.enabled) = starSettings
    }

}
