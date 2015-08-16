//
//  RMSStarView.swift
//  RateMySnack
//
//  Created by Maria Lopez on 7/25/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

class RMSStarView: UIView {
    var stars : [UIView]!
    var enabled : Bool = false {
        didSet {
            self.starEnabled(enabled)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addStars()
    }
    
    func addStars() {
        var starOn = EnabledView()
        var starOff = DisabledView()

        self.stars = [starOff, starOn]
        
        self.addSubview(self.stars[1])
        self.addSubview(self.stars[0])
        
        starOff.setTranslatesAutoresizingMaskIntoConstraints(false)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["v" : starOff]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["v" : starOff]))
        
        starOn.setTranslatesAutoresizingMaskIntoConstraints(false)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["v" : starOn]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["v" : starOn]))
        
        self.enabled = false
    }

    func starEnabled(on:Bool) {
        if on == true {
            self.bringSubviewToFront(self.stars[1])
        } else if on == false {
            self.bringSubviewToFront(self.stars[0])
        }
    
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addStars()
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
