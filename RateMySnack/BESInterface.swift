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

    static func submit(item: SnackProtocol, completionHandler completion: ((err: RMSBackendError?) -> Void)) {
        do {
            let result = try BESInterface.hasSnack(item)
            guard result else {
                // Creates an instance of AllSnack Object
                let snack = PFObject.createAllSnacks(item)

                // Save new snack in background asynhronously
                snack.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    // When the save finishes call the completion block
                    if (success) {
                        completion(err: nil)
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
    
    static func retrieve(requestCompleted request: ((objs: [SnackProtocol], err: RMSBackendError?) -> Void)) {
        
        let findSnacks = PFQuery(className: AllSnacksKeys.allSnacks)
        findSnacks.includeKey(ParseObjectKeys.objectId)
        
        findSnacks.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            var nameOfSnack: [SnackProtocol] = []
            if error == nil {
                if let objs = objects {
                    for i in objs {
                        let fo = Snack(snack: i)
                        nameOfSnack.append(fo)
                    }
                    request(objs: nameOfSnack, err: nil)
                }
            }
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
    
    static func getRatingOfSnack(snack: SnackProtocol, completion: (rating: UInt, err: RMSBackendError?) -> ()) {
      
        func getTotalNumberOf(snack: SnackProtocol)(withRating rating: UInt) throws -> (rating: UInt, total:UInt) {
            assert(RMSStarRatingLimit.minimum < rating && rating <= RMSStarRatingLimit.maximum)
            
            let queryTotal = PFQuery(className: "StarRating")
            
            queryTotal.whereKey("AllSnacks", equalTo: PFObject.createAllSnacks(snack))
            queryTotal.whereKey("Rating", equalTo: rating)
            var err: NSError?
            let totalRatingsForSnack = queryTotal.countObjects(&err)
            if totalRatingsForSnack == -1 {
                throw RMSBackendError.UnexpectedNetworkError
            }
            return (rating: rating, total: UInt(totalRatingsForSnack))
        }
            
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            let totalNumberOfSnacks = getTotalNumberOf(snack)
            do {
                let ratings = [
                    try totalNumberOfSnacks(withRating: 1),
                    try totalNumberOfSnacks(withRating: 2),
                    try totalNumberOfSnacks(withRating: 3),
                    try totalNumberOfSnacks(withRating: 4),
                    try totalNumberOfSnacks(withRating: 5),
                ]
                
                guard let totalRatings: UInt = ratings
                    .map({ UInt($0.total) })
                    .reduce(0, combine: +)
                    where totalRatings != 0 else
                {
                    completion(rating: 0, err: nil)
                    return
                }
                
                guard let sumOfRatings: UInt = ratings
                    .map({ UInt($0.rating) * UInt($0.total) })
                    .reduce(0, combine: +)
                    where sumOfRatings != 0 else
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
