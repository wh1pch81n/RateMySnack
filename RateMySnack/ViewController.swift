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


class SnackObject : FormObject {
	var snackName : String
    
    init(name:String ) {
       snackName = name
    }
}
class ViewController: UIViewController {
    
    var DreamersClass = Dreamers()
    
    override func viewDidLoad() {
        super.viewDidLoad()

		// Do any additional setup after loading the view, typically from a nib.

     var kindBar : SnackObject = SnackObject(name: "Oreos")
        
        BackendDelegate.submit(kindBar, completionHandler:{ (err:NSError) -> Void in
            
        });
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var item: FormObject = FormTest()
        BackEndServer.submit(item, completionHandler:{ (NSError) -> Void in
            println("done")
        })
    }
}

