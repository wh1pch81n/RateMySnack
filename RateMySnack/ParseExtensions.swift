//
//  PFObjectExtension.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 9/12/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Parse
import Bolts

enum ParseObjectKeys: String {
    case ObjectId = "objectId"
    case CreatedAt = "createdAt"
    case UpdatedAt = "updatedAt"
    static let objectId = ParseObjectKeys.ObjectId.rawValue
    static let createdAt = ParseObjectKeys.CreatedAt.rawValue
    static let updatedAt = ParseObjectKeys.UpdatedAt.rawValue
}

