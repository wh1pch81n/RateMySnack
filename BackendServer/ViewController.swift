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
        
        
        BackEndServer.retrieve { (objs: [SnackProtocol], err: RMSBackendError?) -> Void in
            if err == nil {
                for i in objs { // looping though each object *i* in the array *objs*
                    print(i.snackName, terminator: "")
                    print(",")
                }
            } else {
                print(err)
            }
        }
        
        let sn = "kk"
        BackEndServer.submit(Snack(name: sn, description: ""), completionHandler: { (err: RMSBackendError?) -> Void in
            if err == nil {
                print("snack \(sn) saved")
            } else if err == .Duplication {
                print("Already has \(sn)")
            }
        })
    }
    
}

