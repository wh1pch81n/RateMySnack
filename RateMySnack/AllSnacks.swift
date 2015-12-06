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

enum AllSnacksKeys: String {
    case AllSnacks
    case SnackName
    case SnackDescription
    static let allSnacks = AllSnacksKeys.AllSnacks.rawValue
    static let snackName = AllSnacksKeys.SnackName.rawValue
    static let snackDescription = AllSnacksKeys.SnackDescription.rawValue
}

/**
Not a true subclass of AllSnacks but at least this method allows for us to use the properties of AllSnacks.
In time there may be more Parse classes than Allsnacks therefore there are asserts in this code to verify that it is the correct class.
*/
extension PFObject: SnackProtocol {
    var snackName: String {
        get {
            assert(parseClassName == AllSnacksKeys.allSnacks)
            let _snackName: AnyObject? = self[AllSnacksKeys.snackName]
            assert(_snackName != nil, "Parse Server Object has nil snackName on \(self)")
            return _snackName as! String
        }
        set {
            assert(parseClassName == AllSnacksKeys.allSnacks)
            self[AllSnacksKeys.snackName] = newValue
        }
    }
    
    var snackDescription: String {
        get {
            assert(parseClassName == AllSnacksKeys.allSnacks)
            let _snackDescription: AnyObject? = self[AllSnacksKeys.snackDescription]
            assert(_snackDescription != nil, "Parse Server Object has nil snackDescription on \(self)")
            return _snackDescription as! String
        }
        set {
            assert(parseClassName == AllSnacksKeys.allSnacks)
            self[AllSnacksKeys.snackDescription] = newValue
        }
    }
	
    static func createAllSnacks(snack: SnackProtocol) -> PFObject {
        let obj = PFObject(className: AllSnacksKeys.allSnacks)
        obj.objectId = snack.objectId
        obj[AllSnacksKeys.snackName] = snack.snackName
        obj[AllSnacksKeys.snackDescription] = snack.snackDescription
        return obj
    }
}
