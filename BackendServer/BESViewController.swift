//
//  ViewController.swift
//  BackendServer
//
//  Created by Derrick  Ho on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

class BESViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var s = Snack(name: "", description: "")
        s.objectId = "gppjXFzUQg"
        BESInterface.getRatingOfSnack(s) { (rating, err) -> () in
            if err != nil {
                
            }
            print(rating)
        }
    
    }
    
}

