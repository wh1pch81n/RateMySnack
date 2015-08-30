//
//  RMSStarView.swift
//  RateMySnack
//
//  Created by Maria Lopez on 7/25/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

func starImage(rect: CGRect, fillColor: UIColor, borderColor: UIColor) -> UIImage {
    
    UIGraphicsBeginImageContext(rect.size)
    var starArmY = CGRectGetMaxY(rect) * 0.4
    var starFeetOffset = CGRectGetMaxX(rect) * 0.15
    var starTopOffset = CGRectGetMaxY(rect) * 0.05
    var strokeWidth = CGFloat(2.0)
    
    var context = UIGraphicsGetCurrentContext()
    var path: CGMutablePathRef = CGPathCreateMutable()
    CGPathMoveToPoint(path, nil, CGRectGetMinX(rect) + starFeetOffset, CGRectGetMaxY(rect) - strokeWidth) // BL
    CGPathAddLineToPoint(path, nil, CGRectGetMidX(rect), CGRectGetMinY(rect) + starTopOffset + strokeWidth) // Top
    CGPathAddLineToPoint(path, nil, CGRectGetMaxX(rect) - starFeetOffset, CGRectGetMaxY(rect) - strokeWidth) // BR
    CGPathAddLineToPoint(path, nil, CGRectGetMinX(rect) + strokeWidth, starArmY) // Left
    CGPathAddLineToPoint(path, nil, CGRectGetMaxX(rect) - strokeWidth, starArmY) // Right
    CGPathCloseSubpath(path)
    
    CGContextAddPath(context, path)
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor)
    CGContextSetLineWidth(context, strokeWidth)
    CGContextStrokePath(context)
    
    CGContextAddPath(context, path)
    CGContextSetFillColorWithColor(context, fillColor.CGColor)
    CGContextFillPath(context)
    
    var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    return image
}

@IBDesignable
class RMSStarView: UIView {
    lazy var starOn: UIView = { EnabledView(frame: CGRect(origin: CGPointZero, size: self.frame.size)) }()
    lazy var starOff: UIView = { DisabledView(frame: CGRect(origin: CGPointZero, size: self.frame.size)) }()
    var enabled : Bool = false {
        didSet {
            if enabled == true {
                self.bringSubviewToFront(self.starOn)
            } else  {
                self.bringSubviewToFront(self.starOff)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addStars()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addStars()
    }

    override func prepareForInterfaceBuilder() {
        addStars()
        starOn.alpha = 0.5
        starOff.alpha = 0.5
    }
    
    func addStars() {
        if self.frame == CGRectZero {
            return
        }

        self.addSubview(self.starOn)
        self.addSubview(self.starOff)
        
        starOff.setTranslatesAutoresizingMaskIntoConstraints(false)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[v]-5-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["v" : starOff]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[v]-5-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["v" : starOff]))
        
        starOn.setTranslatesAutoresizingMaskIntoConstraints(false)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[v]-5-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["v" : starOn]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[v]-5-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: ["v" : starOn]))
        
        self.enabled = false
    }
}

private class EnabledView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = starImage(frame, UIColor.yellowColor(), UIColor.orangeColor())
        self.userInteractionEnabled = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class DisabledView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = starImage(frame, UIColor.lightGrayColor(), UIColor.darkGrayColor())
        self.userInteractionEnabled = false
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
