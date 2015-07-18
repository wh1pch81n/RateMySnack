//
//  ViewController.swift
//  RateMySnack
//
//  Created by Ho, Derrick on 7/10/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController {
    
    var DreamersClass = Dreamers()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DreamersClass.sayHello()
        
        for i in 1...45{
            DreamersClass.sayHello()
        }
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

