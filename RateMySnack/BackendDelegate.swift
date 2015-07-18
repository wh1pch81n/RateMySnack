//
//  BackendDelegate.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation

protocol FormObject {
    var snackName:String { get set }
}

protocol BackendDelegate {
    func submit(item:FormObject, completionHandler completion:((NSError) -> Void));
    func retrieve(requestCompleted request:((NSError, [FormObject]) -> Void));
}