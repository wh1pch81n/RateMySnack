//
//  ViewController.swift
//  RateMySnack
//
//  Created by Ho, Derrick on 7/10/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var greeting: UILabel!
	override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
        var greetme = Derrick()
        greetme.sayHello()
      
        for i in 1...100 {
            greetme.sayHello()
            println(i)
        }
        
        
        
	}

	 override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

