//
//  CommonProtocols.swift
//  RateMySnack
//
//  Created by Derrick  Ho on 1/23/16.
//  Copyright © 2016 Ho, Derrick. All rights reserved.
//

import Foundation

//----------------------------
// Contract between client and backend
protocol SnackProtocol {
	var snackName: String { get set }
	var snackDescription: String { get set }
}

