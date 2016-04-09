//
//  RMSStarView.swift
//  RateMySnack
//
//  Created by Maria Lopez on 7/25/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit

/**
Draws a star on the given context

:param: context the context to draw on
:param: rect the frame on which to draw inside of
:param: fillColor the fill color of the star
:param: borderColor the border color of the star
*/
func starDrawing(context: CGContextRef, rect: CGRect) -> (UIColor, UIColor) -> () {
	return { (fillColor: UIColor, borderColor: UIColor) -> () in
		// Offsets used to give the star a more star-like look within the containing frame
		let starArmY = CGRectGetMaxY(rect) * 0.4
		let starFeetOffset = CGRectGetMaxX(rect) * 0.15
		let starTopOffset = CGRectGetMaxY(rect) * 0.05
		let strokeWidth = CGFloat(2.0)
		
		// A path for a 5-point star
		let path: CGMutablePathRef = CGPathCreateMutable()
		CGPathMoveToPoint(path, nil, CGRectGetMinX(rect) + starFeetOffset, CGRectGetMaxY(rect) - strokeWidth) // BL
		CGPathAddLineToPoint(path, nil, CGRectGetMidX(rect), CGRectGetMinY(rect) + starTopOffset + strokeWidth) // Top
		CGPathAddLineToPoint(path, nil, CGRectGetMaxX(rect) - starFeetOffset, CGRectGetMaxY(rect) - strokeWidth) // BR
		CGPathAddLineToPoint(path, nil, CGRectGetMinX(rect) + strokeWidth, starArmY) // Left
		CGPathAddLineToPoint(path, nil, CGRectGetMaxX(rect) - strokeWidth, starArmY) // Right
		CGPathCloseSubpath(path) // connects the last point added with the initial point
		
		// Draw the star strokes on to the context
		CGContextAddPath(context, path)
		CGContextSetStrokeColorWithColor(context, borderColor.CGColor)
		CGContextSetLineWidth(context, strokeWidth)
		CGContextStrokePath(context)
		
		// Fill in the star with color on the context
		CGContextAddPath(context, path)
		CGContextSetFillColorWithColor(context, fillColor.CGColor)
		CGContextFillPath(context)
	}
}

@IBDesignable
class RMSStarView: UIView {
    var enabled : Bool = false {
        didSet {
            self.setNeedsDisplay() // Redraws the star
        }
    }
    
    override func drawRect(rect: CGRect) {
        let drawing = starDrawing(UIGraphicsGetCurrentContext()!, rect: rect)
        if self.enabled {
            drawing(UIColor.yellowColor(), UIColor.orangeColor())
        } else {
             drawing(UIColor.grayColor(), UIColor.darkGrayColor())
        }
    }
}
