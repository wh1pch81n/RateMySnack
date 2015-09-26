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
        BESInterface.getRatingOfSnack(Snack(objectId: "gppjXFzUQg", name: "", description: "")) { (rating, err) -> () in
            if err != nil {
                
            }
            print(rating)
        }
    
    }
    
}

