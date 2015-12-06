//
//  BackEndServer.swift
//  RateMySnack
//
//  Created by S. Han on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import Parse
import Bolts

class BESInterface: BackendDelegate {

    static func submit(item: SnackWithRatingProtocol, completionHandler completion: ((err: RMSBackendError?) -> Void)) {
        do {
            let result = try BESInterface.hasSnack(item)
            guard result else {
                // Creates an instance of AllSnack Object
                let snack = PFObject.createAllSnacks(item)

                // Save new snack in background asynhronously
                snack.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    // When the save finishes call the completion block
                    if (success) {
						var snackWithRating = Snack(name: item.snackName, description: item.snackDescription, rating: item.snackRating)
						snackWithRating.objectId = snack.objectId!
						BESInterface.submitRatingForSnack(snackWithRating, completion: { (err: NSError?) -> () in
							completion(err: nil)
						})
                        return
                    }
                    if error?.code == PFErrorCode.ErrorTimeout.rawValue {
                        completion(err: RMSBackendError.Timeout)
                        return
                    }
                    completion(err: RMSBackendError.UnexpectedNetworkError) //Lost coonnection
                }
                return
            }
            completion(err: RMSBackendError.Duplication)
        } catch {
            completion(err: RMSBackendError.UnexpectedNetworkError)
        }
    }
    
    static func retrieve(requestCompleted request: ((objs: [SnackWithRatingProtocol], err: RMSBackendError?) -> Void)) {
        
        let findSnacks = PFQuery(className: AllSnacksKeys.allSnacks)
        findSnacks.includeKey(ParseObjectKeys.objectId)
		
		var nameOfSnack: [Int : (name: String, description: String, rating: Int)] = [:]
		let group = dispatch_group_create()
		dispatch_group_enter(group)
        findSnacks.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objs = objects {
                    for i in objs.enumerate() {
						{ (row: Int, element: PFObject) -> () in
							dispatch_group_enter(group)
							BESInterface.getRatingOfSnack(element, completion: { (rating, err) -> () in
								nameOfSnack[row] = (name: element.snackName, description: element.snackDescription, rating: Int(rating))
								dispatch_group_leave(group)
							})
						}(i.index, i.element)
                    }
                }
            }
			dispatch_group_leave(group)
		}
		
		dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
			let arr: [(name: String, description: String, rating: Int)] = Array(0..<nameOfSnack.count).map({ nameOfSnack[$0]! })
			let arr2: [SnackWithRatingProtocol] = arr.map({ Snack(name: $0.name, description: $0.description, rating: $0.rating) })
			request(objs: arr2, err: nil)
		}
    }
    
    private static func hasSnack(snack: SnackProtocol, withClassName name: String = AllSnacksKeys.allSnacks) throws -> Bool {
        // Make Query "AllSnacks"
        let queryAllSnack = PFQuery(className: name) //1.querying for objects with the class name "AllSnacks"
        
        // Refine queryAllSnack query to include all with the specified snameName
        
        queryAllSnack.whereKey(AllSnacksKeys.snackName, equalTo: snack.snackName) //2.Key = colum ; equalTo <the input of data>
        queryAllSnack.selectKeys([AllSnacksKeys.snackName]) //3.Only pulling data from the specified key
        queryAllSnack.limit = 1 //4.setting a limit of returning of the same snack as 1
        
        do {
            // Begin the query and perform it it synchronously
            var objectsThatMatch : [PFObject]?
            objectsThatMatch = try queryAllSnack.findObjects()
            // If objectsThatMatch is empty then return false otherwise return true
            if let _objectsThatMatch = objectsThatMatch
                where _objectsThatMatch.count > 0 {
                    return true
            }
            return false
        } catch {
            throw RMSBackendError.UnexpectedNetworkError
        } //TODO:you can actually simplied this line of code with countObject
    }
	
	static func submitRatingForSnack(snack: SnackWithRatingProtocol, completion: (err: NSError?) -> ()) {
		let ratingObject = PFObject(className: StarRatingKeys.StarRating.rawValue)
		let allSnack = PFObject(className: AllSnacksKeys.allSnacks)
		allSnack.objectId = snack.objectId!
		ratingObject[StarRatingKeys.allSnacks] = allSnack
		ratingObject[StarRatingKeys.rating] = snack.snackRating
//		ratingObject[StarRatingKeys.User.rawValue] = 
		ratingObject.saveInBackgroundWithBlock { (b: Bool, err: NSError?) -> Void in
			completion(err: err)
		}
	}
    
    /**
    Retrieves the average rating of a SnackProtocol object based on its objectId. DEPRECATED: (Will be replaced with an Cloud Code Equivalent)
    - parameter snack: An object that conforms to the SnackProtocol
    - parameter completion: a block object with rating and err
    */
    typealias RatingTotal = (rating: UInt, total:UInt)
    static func getRatingOfSnack(snack: SnackProtocol, completion: (rating: UInt, err: RMSBackendError?) -> ()) {
      
        func getTotalNumberOf(snack: SnackProtocol, withRating rating: UInt) throws -> RatingTotal {
            assert(RMSStarRatingLimit.minimum < rating && rating <= RMSStarRatingLimit.maximum)
            assert(snack.objectId != nil)
            
            let queryTotal = PFQuery(className: StarRatingKeys.starRating)
            
            queryTotal.whereKey(StarRatingKeys.allSnacks, equalTo: PFObject.createAllSnacks(snack))
            queryTotal.whereKey(StarRatingKeys.rating, equalTo: rating)
            var err: NSError?
            let totalRatingsForSnack = queryTotal.countObjects(&err)
            if totalRatingsForSnack == -1 {
                throw RMSBackendError.UnexpectedNetworkError
            }
            return (rating: rating, total: UInt(totalRatingsForSnack))
        }
            
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            do {
                var ratings = [RatingTotal](); for i: UInt in 1...5 {
                    ratings.append(try getTotalNumberOf(snack, withRating: i))
                }
                
                guard let totalRatings: UInt = ratings.map({ $0.total }).reduce(0, combine: +)
                    , let sumOfRatings: UInt = ratings.map({ $0.rating * $0.total }).reduce(0, combine: +)
                    where (totalRatings & sumOfRatings) != 0 else
                {
                    completion(rating: 0, err: nil)
                    return
                }
                
                let rating = sumOfRatings / totalRatings
                completion(rating: rating, err: nil)
            } catch {
                completion(rating:0, err: RMSBackendError.UnexpectedNetworkError)
            }
        }
    }
}
