//
//  PFObjectExtension.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 9/12/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Parse
import Bolts

enum ParseObjectKeys : String {
    case ObjectId = "objectId"
    case CreatedAt = "createdAt"
    case UpdatedAt = "updatedAt"
}

enum ParseKeys : String {
    case ApplicationId = "r7EqA8YMRx0ew2OaE2ebKZnErKWdJgmR1hBtQBAQ"
    case ClientKey = "tIWDqmLYrdcquuzznkZS9iJ5CqX8ieOYZhhT4bnz"
}

extension PFObject {
    subscript(property: AllSnacksKeys) -> AnyObject? {
        get {
            return self[property.rawValue]
        }
        set(newValue) {
            self[property.rawValue] = newValue
        }
    }
    
}
