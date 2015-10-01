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

enum StarRatingKeys: String {
    case StarRating
    case Rating
    case AllSnacks
    case User
    static let starRating = StarRatingKeys.StarRating.rawValue
    static let rating = StarRatingKeys.Rating.rawValue
    static let allSnacks = StarRatingKeys.AllSnacks.rawValue
    static let user = StarRatingKeys.User.rawValue
}