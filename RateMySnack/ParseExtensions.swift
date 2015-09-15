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
    static var objectId = ParseObjectKeys.ObjectId.rawValue
    static var createdAt = ParseObjectKeys.CreatedAt.rawValue
    static var updatedAt = ParseObjectKeys.UpdatedAt.rawValue
}

enum ParseKeys : String {
    case ApplicationId = "r7EqA8YMRx0ew2OaE2ebKZnErKWdJgmR1hBtQBAQ"
    case ClientKey = "tIWDqmLYrdcquuzznkZS9iJ5CqX8ieOYZhhT4bnz"
    static var applicationId = ParseKeys.ApplicationId.rawValue
    static var clientKey = ParseKeys.ClientKey.rawValue
}

extension PFObject {
    subscript(property: AllSnacksKeys) -> AnyObject? {
        get {
            assert(self.parseClassName == AllSnacksKeys.allSnacks)
            return self[property.rawValue]
        }
        set(newValue) {
            assert(self.parseClassName == AllSnacksKeys.allSnacks)
            self[property.rawValue] = newValue
        }
    }
    
}
