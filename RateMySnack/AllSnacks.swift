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

enum AllSnacksKeys : String {
    case AllSnacks = "AllSnacks"
    case SnackName = "SnackName"
    case SnackDescription = "SnackDescription"
    static let allSnacks = AllSnacksKeys.AllSnacks.rawValue
    static let snackName = AllSnacksKeys.SnackName.rawValue
    static let snackDescription = AllSnacksKeys.SnackDescription.rawValue
}

//typealias AllSnacks = PFObject

class AllSnacks : PFObject, SnackProtocol {
    var snackName:String {
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
    
    var snackDescription:String {
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
    
    static func createAllSnackObject(snack: SnackProtocol) -> AllSnacks {
        var obj = PFObject(className: AllSnacksKeys.allSnacks)
        obj.snackName = snack.snackName
        obj.snackDescription = snack.snackDescription
        return obj
    }
}
