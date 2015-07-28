//
//  ViewController.swift
//  RateMySnack
//
//  Created by Ho, Derrick on 7/10/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

class SnackObject : SnackProtocol {
	var name:String
    var description:String
    init(name:String, description:String) {
       self.name = name
        self.description = description
    }
}
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var kindBar : SnackObject = SnackObject(name: "PopCorn", description: "Core that make the world go round...")
        BackEndServer.submit(kindBar, completionHandler:{ (err:NSError?) -> Void in
            print("Just submitted Snack")
        });
    }
    
}

