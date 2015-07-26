//
//  Snack.swift
//  RateMySnack
//
//  Created by S. Han on 7/25/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

struct Snack : FormObject {
    var snackName : String
    
    init(name:String ) {
        snackName = name
    }
}
