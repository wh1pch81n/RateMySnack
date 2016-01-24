//
//  CommonProtocols.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 1/23/16.
//  Copyright © 2016 Ho, Derrick. All rights reserved.
//

import Foundation

//----------------------------
// Contract between client and backend
protocol SnackProtocol {
	var snackName: String { get set }
	var snackDescription: String { get set }
}

protocol SnackRatingProtocol {
	var snackRating: Int { get set }
	var allSnacks: AllSnacksProtocol? { get set }
	var user: UserProtocol? { get set }
}


protocol UserProtocol {
	
}

//----------------------------
// client side

//----------------------------
// backend
protocol ParseObjectProtocol {
	var objectId: String? { get set }
	var updatedAt: NSDate? { get }
	var createdAt: NSDate? { get }
	
	func saveInBackgroundWithBlock(block: ((Bool, NSError?) -> Void)?)
}

protocol AllSnacksProtocol: ParseObjectProtocol, SnackProtocol {
	
}

protocol StarRatingProtocol: ParseObjectProtocol, SnackRatingProtocol {
	
}
