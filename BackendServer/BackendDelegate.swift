//
//  BackendDelegate.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation

typealias SnackWithRatingBlock = (SnackProtocol, ((rating: UInt, error: RMSBackendError?) -> ()) -> ())

enum RMSBackendError: ErrorType {
    case None
    case Timeout
    case Duplication
    case UnexpectedNetworkError
}

//----------------------------
// backend
protocol ParseObjectProtocol {
	var objectId: String? { get set }
	var updatedAt: NSDate? { get }
	var createdAt: NSDate? { get }
	
	func saveInBackgroundWithBlock(block: ((Bool, NSError?) -> Void)?)
}

protocol AllSnacksProtocol: ParseObjectProtocol, SnackProtocol {
	static func initWithAllSnacks() -> AllSnacksProtocol
}

protocol SnackRatingProtocol {
	var snackRating: Int { get set }
	var allSnacks: AllSnacksProtocol? { get set }
}

protocol StarRatingProtocol: ParseObjectProtocol, SnackRatingProtocol {
	static func initWithStarRating() -> StarRatingProtocol
}

protocol BackendDelegate {
    /**
    Submits ⬆️ a FormObject to the object that comforms to BackendDelegate
    
    - parameter item: an object that conforms to FormObject
    - parameter completion: a block with one parameter for NSError? and void return type.  It's called by the object that conforms to the BackendDelegate when the request finishes
    */
	static func submit(item: SnackProtocol, rating: Int, completionHandler completion: ((err: RMSBackendError?) -> Void))
    /**
    Requests ⬇️ all snack data from the server
    
    - parameter request: a block with one parameter for NSError? and one parameter for an array of FormObjects. It is called when the request to the server is complete.
    */
	
    static func retrieve(requestCompleted request: ((objs: [SnackWithRatingBlock], err: RMSBackendError?) -> Void))
}
