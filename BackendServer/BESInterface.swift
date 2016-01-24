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

	static func submit(item: SnackProtocol, rating: Int, completionHandler completion: ((err: RMSBackendError?) -> Void)) {
        do {
            let result = try BESInterface.hasSnack(item)
            guard result else {
                // Creates an instance of AllSnack Object
                var snack = PFObject.initWithAllSnacks()
				snack.snackName = item.snackName
				snack.snackDescription = item.snackDescription

                // Save new snack in background asynhronously
                snack.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    // When the save finishes call the completion block
                    if (success) {
						BESInterface.submitRating(rating, forSnack:snack, completion: { (err: NSError?) -> () in
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
    
    static func retrieve(requestCompleted request: ((objs: [Dictionary<String, AnyObject>], err: RMSBackendError?) -> Void)) {
        
        let findSnacks = PFQuery(className: PC_ALLSNACKS)
		
		var nameOfSnack = [Int:[String : AnyObject]]()
		let group = dispatch_group_create()
		dispatch_group_enter(group)
        findSnacks.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            guard error == nil,
			let objs = objects
			else {
				return
			}
			let arrOfAllSnacks = objs.map({ $0 as AllSnacksProtocol })
			arrOfAllSnacks.enumerate().forEach { (i) -> () in
				{ (row: Int, element: AllSnacksProtocol) -> () in
					dispatch_group_enter(group)
					BESInterface.getRatingOfSnack(element, completion: { (rating, err) -> () in
						nameOfSnack[row] = [
							ALLSNACKS_SNACKNAME : element.snackName,
							ALLSNACKS_SNACKDESCRIPTION : element.snackDescription,
							STARRATING_RATING : Int(rating)
						]
						
						dispatch_group_leave(group)
					})
				}(i.index, i.element)
            }
			dispatch_group_leave(group)
		}
		
		dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
			let arr: [Dictionary<String, AnyObject>] = Array(0..<nameOfSnack.count).map {
				nameOfSnack[$0]!
			}
			request(objs: arr, err: nil)
		}
    }
    
    private static func hasSnack(snack: SnackProtocol) throws -> Bool {
        // Make Query "AllSnacks"
        let queryAllSnack = PFQuery(className: PC_ALLSNACKS) //1.querying for objects with the class name "AllSnacks"
        
        // Refine queryAllSnack query to include all with the specified snameName
        
        queryAllSnack.whereKey(ALLSNACKS_SNACKNAME, equalTo: snack.snackName) //2.Key = colum ; equalTo <the input of data>
        queryAllSnack.selectKeys([ALLSNACKS_SNACKNAME]) //3.Only pulling data from the specified key
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
	
	static func submitRating(rating: Int, forSnack snack: AllSnacksProtocol, completion: (err: NSError?) -> ()) {
		var ratingObject = PFObject.initWithStarRating()
		ratingObject.allSnacks = snack
		ratingObject.snackRating = rating
//		ratingObject.user = user
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
    private static func getRatingOfSnack(snack: AllSnacksProtocol, completion: (rating: UInt, err: RMSBackendError?) -> ()) {
		assert(snack.objectId != nil)
		func getTotalNumberOf(snack: AllSnacksProtocol, withRating rating: UInt) throws -> RatingTotal {
            let queryTotal = PFQuery(className: PC_STARRATING)
			var allSnackPtr = PFObject.initWithAllSnacks()
			allSnackPtr.objectId = snack.objectId
            queryTotal.whereKey(STARRATING_ALLSNACKS, equalTo: allSnackPtr as! PFObject)
            queryTotal.whereKey(STARRATING_RATING, equalTo: rating)
            var err: NSError?
            let totalRatingsForSnack = queryTotal.countObjects(&err)
            if totalRatingsForSnack == -1 {
                throw RMSBackendError.UnexpectedNetworkError
            }
            return (rating: rating, total: UInt(totalRatingsForSnack))
        }
            
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            do {
                var ratings = [RatingTotal]()
				for i: UInt in 1...5 {
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
