//
//  ViewController.swift
//  RateMySnack
//
//  Created by Ho, Derrick on 7/10/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

class SnackObject : FormObject {
	var snackName : String
    
    init(name:String ) {
       snackName = name
    }
}
class ViewController: UIViewController {
    
        @IBAction func buttonPressed(sender: UIButton) {
        
        
        var starRateView = UIButton()
        var viewState = UIButton()
            
//            if     {
//            } else

            
            }
    

            
     
        override func viewDidLoad() {
        super.viewDidLoad()
        
        var starView = RMSStarView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.view.addSubview(starView)
        
        starView.starEnabled(false)
        
    }
    
        
        
        
//        var kindBar : SnackObject = SnackObject(name: "PopCorn")
//        BackEndServer.submit(kindBar, completionHandler:{ (err:NSError?) -> Void in
//            print("Just submitted Snack")
//        });
    }
    


