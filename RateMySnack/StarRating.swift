//
//  StarRating.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 9/25/15.
//  Copyright © 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import Parse
import Bolts

extension StarRatingProtocol where Self: PFObject {
	/** Creates a StarRatingProtocol conforming Object*/
	static func initWithStarRating() -> StarRatingProtocol {
		return PFObject(className: PC_STARRATING)
	}
}

extension PFObject: StarRatingProtocol {
	var snackRating: Int {
		get {
			assert(self.parseClassName == PC_STARRATING)
			return self["Rating"] as! Int
		} set {
			assert(self.parseClassName == PC_STARRATING)
			self["Rating"] = newValue
		}
	}
	var allSnacks: AllSnacksProtocol? {
		get {
			assert(self.parseClassName == PC_STARRATING)
			return self["AllSnacks"] as! AllSnacksProtocol?
		} set {
			assert(self.parseClassName == PC_STARRATING)
			self["AllSnacks"] = newValue as! PFObject
		}
	}
	
}