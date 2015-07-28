//
//  ViewController.swift
//  RateMySnack
//
//  Created by Ho, Derrick on 7/10/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var kindBar : SnackObject = SnackObject(name: "PopCorn")
        BackEndServer.submit(kindBar, completionHandler:{ (err:NSError?) -> Void in
            print("Just submitted Snack")
        });
    }
    
}

