//
//  BackendDelegate.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation

enum RMSBackendError : Int {
    case Timeout = 1
    case Duplication = 2
    case UnexpectedNetworkError = 404
}

/**
Describes the kind of object that will hold on to snack info.
*/
protocol SnackProtocol {
    var name:String { get set }
    var description:String { get set }
}

protocol BackendDelegate {
    /**
    Submits ⬆️ a FormObject to the object that comforms to BackendDelegate
    
    :param: item an object that conforms to FormObject
    :param: completion a block with one parameter for NSError? and void return type.  It's called by the object that conforms to the BackendDelegate when the request finishes
    */
    static func submit(item:SnackProtocol, completionHandler completion:((err:NSError?) -> Void))
    /**
    Requests ⬇️ all snack data from the server
    
    :param: request a block with one parameter for NSError? and one parameter for an array of FormObjects. It is called when the request to the server is complete.
    */
    static func retrieve(requestCompleted request:((err:NSError?, objs:[SnackProtocol]) -> Void))
}
