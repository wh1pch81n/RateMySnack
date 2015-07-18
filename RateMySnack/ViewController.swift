//
//  ViewController.swift
//  RateMySnack
//
//  Created by Ho, Derrick on 7/10/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit
class SnackObject : FormObject {
	var snackName : String 
}
class ViewController: UIViewController {
    
    var DreamersClass = Dreamers()
    
    override func viewDidLoad() {
        super.viewDidLoad()

		// Do any additional setup after loading the view, typically from a nib.

     var kindBar : SnackObject = SnackObject()
     kindBar.snackName = "snickers"
     kindBar.snackName = "Luna Bar" 
        
	}

	 override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

