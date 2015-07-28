//
//  ViewController.swift
//  BackendServer
//
//  Created by Derrick  Ho on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

// This is to be used only for Testing
class FormTest: SnackProtocol {
    var name:String = "3 musketeers"
    var description:String = "A chocolate"
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var item: SnackProtocol = FormTest()
        BackEndServer.submit(item, completionHandler:{ (err:NSError?) -> Void in
            println("done")
        })
    }

}

