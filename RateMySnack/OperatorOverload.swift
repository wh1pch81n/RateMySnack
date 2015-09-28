//
//  OperatorOverload.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 9/28/15.
//  Copyright © 2015 Ho, Derrick. All rights reserved.
//

import Foundation

infix operator >% { associativity right precedence 90 }
/**
Looks like a pair of scissors.  Will create a split string based on delimiters
- parameter stringToSplit: This string will be split based on the delimiter
- parameter delimiters: Each character in this string will be used to separate stringToSplit
- returns: An array of string components separated by the delimiters
*/
func >%(stringToSplit: String, delimiters: String) -> [String] {
    return (stringToSplit as NSString).componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: delimiters))
}