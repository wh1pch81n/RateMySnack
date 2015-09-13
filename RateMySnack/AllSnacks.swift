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
}

typealias AllSnacks = PFObject

extension AllSnacks {
    static func AllSnackObject() -> AllSnacks {
        return PFObject(className: AllSnacksKeys.AllSnacks.rawValue)
    }
}
