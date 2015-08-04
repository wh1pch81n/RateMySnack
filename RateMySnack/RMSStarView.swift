//
//  RMSStarView.swift
//  RateMySnack
//
//  Created by Maria Lopez on 7/25/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

class RMSStarView: UIView {
    var stars : [UIView]
    override init(frame: CGRect) {
        var starOn = EnabledView()
        starOn.frame = frame
        
        var starOff = DisabledView()
        starOff.frame = frame
        
        self.stars = [starOff, starOn]
        
        super.init(frame: frame)
        
        self.addSubview(self.stars[1])
        self.addSubview(self.stars[0])
        
        
        
        self.starEnabled(false)

    }

    func starEnabled(on:Bool) {
        if on == true {
            self.bringSubviewToFront(self.stars[1])
        } else if on == false {
            self.bringSubviewToFront(self.stars[0])
        }
    
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class EnabledView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellowColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class DisabledView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = CGFloat(1)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
