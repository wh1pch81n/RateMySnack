//
//  StarRating.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 9/25/15.
//  Copyright © 2015 Ho, Derrick. All rights reserved.
//

import Foundation
enum RMSStarRatingLimit: UInt {
    case Minimum = 0
    case Maximum = 5
    static let minimum = RMSStarRatingLimit.Minimum.rawValue
    static let maximum = RMSStarRatingLimit.Maximum.rawValue
}