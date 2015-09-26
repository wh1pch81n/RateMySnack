//
//  BackendDelegate.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation

enum RMSBackendError: ErrorType {
    case None
    case Timeout
    case Duplication
    case UnexpectedNetworkError
}

/**
Describes the kind of object that will hold on to snack info.
*/
protocol SnackProtocol {
    var snackName: String { get set }
    var snackDescription: String { get set }
}

protocol BackendDelegate {
    /**
    Submits ⬆️ a FormObject to the object that comforms to BackendDelegate
    
    - parameter item: an object that conforms to FormObject
    - parameter completion: a block with one parameter for NSError? and void return type.  It's called by the object that conforms to the BackendDelegate when the request finishes
    */
    static func submit(item: SnackProtocol, completionHandler completion: ((err: RMSBackendError?) -> Void))
    /**
    Requests ⬇️ all snack data from the server
    
    - parameter request: a block with one parameter for NSError? and one parameter for an array of FormObjects. It is called when the request to the server is complete.
    */
    static func retrieve(requestCompleted request: ((objs: [SnackProtocol], err: RMSBackendError?) -> Void))
}
