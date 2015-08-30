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
    
    @IBAction func tappedStar(buttonthatwasjustclicked: UIButton) {
        
        var tag = buttonthatwasjustclicked.tag
        
        if tag == 1 {
            starZero.enabled = true
            starOne.enabled = false
            starTwo.enabled = false
            starThree.enabled = false
            starFour.enabled = false
            
        }
        if tag == 2 {
            starZero.enabled = true
            starOne.enabled = true
            starTwo.enabled = false
            starThree.enabled = false
            starFour.enabled = false
            
        }
        if tag == 3 {
            starZero.enabled = true
            starOne.enabled = true
            starTwo.enabled = true
            starThree.enabled = false
            starFour.enabled = false
            
        }
        if tag == 4 {
            starZero.enabled = true
            starOne.enabled = true
            starTwo.enabled = true
            starThree.enabled = true
            starFour.enabled = false
            
        }
        if tag == 5 {
            starZero.enabled = true
            starOne.enabled = true
            starTwo.enabled = true
            starThree.enabled = true
            starFour.enabled = true
        }
        
    }

}
