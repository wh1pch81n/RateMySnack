//
//  AllSnacks.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 9/11/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import Parse
import Bolts

extension AllSnacksProtocol where Self: PFObject {
	/** Creates a ALLSnackProtocol conforming Object*/
	static func initWithAllSnacks() -> AllSnacksProtocol {
		return PFObject(className: PC_ALLSNACKS)
	}
}

extension PFObject: AllSnacksProtocol {
	public var snackName: String {
		get {
			assert(self.parseClassName == PC_ALLSNACKS)
			return self["SnackName"] as! String
		} set {
			assert(self.parseClassName == PC_ALLSNACKS)
			self["SnackName"] = newValue
		}
	}
	
	public var snackDescription: String {
		get {
			assert(self.parseClassName == PC_ALLSNACKS)
			return self["SnackDescription"] as! String
		} set {
			assert(self.parseClassName == PC_ALLSNACKS)
			self["SnackDescription"] = newValue
		}
	}
	
}


