//
//  ViewController.swift
//  BackendServer
//
//  Created by Derrick  Ho on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        BackEndServer.retrieve { (err: NSError?, objs: [SnackProtocol] ) -> Void in
            if err == nil {
                for i in objs { // looping though each object *i* in the array *objs*
                    print(i.name)
                    println(",")
                }
            } else {
                println(err)
            }
        }
    }
    
}

