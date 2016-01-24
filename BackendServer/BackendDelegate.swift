import Foundation

public typealias SnackWithRatingBlock = (SnackProtocol, ((rating: UInt, error: RMSBackendError?) -> ()) -> ())

/** Used by the backend to inform the frontend of an error*/
public enum RMSBackendError: ErrorType {
    case None
    case Timeout
    case Duplication
    case UnexpectedNetworkError
}

/** Used internally as a wrapper around the PFObject */
protocol ParseObjectProtocol {
	var objectId: String? { get set }
	var updatedAt: NSDate? { get }
	var createdAt: NSDate? { get }
	
	func saveInBackgroundWithBlock(block: ((Bool, NSError?) -> Void)?)
}

/** Used internally as a wrapper around the PFObject to make it easier to access properties related to the AllSnacks class*/
protocol AllSnacksProtocol: ParseObjectProtocol, SnackProtocol {
	static func initWithAllSnacks() -> AllSnacksProtocol
}

/** Defines a protocol specifying the unique traits of a StarRating Class*/
protocol SnackRatingProtocol {
	var snackRating: Int { get set }
	var allSnacks: AllSnacksProtocol? { get set }
}

/** Used internally as a wrapper around the PFObject to make it easier to access properties related to the SnackRating class*/
protocol StarRatingProtocol: ParseObjectProtocol, SnackRatingProtocol {
	static func initWithStarRating() -> StarRatingProtocol
}

/** Defines a protocol defining the minimum requirements for class to be a backend delegate */
public protocol BackendDelegate {
	
    /**
    Submits ⬆️ a FormObject to the object that comforms to BackendDelegate
    
    - parameter item: an object that conforms to FormObject
    - parameter completion: a block with one parameter for NSError? and void return type.  It's called by the object that conforms to the BackendDelegate when the request finishes
    */
	func submit(item: SnackProtocol, rating: Int, completionHandler completion: ((err: RMSBackendError?) -> Void))
    /**
    Requests ⬇️ all snack data from the server
    
    - parameter request: a block with one parameter for NSError? and one parameter for an array of FormObjects. It is called when the request to the server is complete.
    */
	
	func retrieve(requestCompleted request: ((objs: [SnackWithRatingBlock], err: RMSBackendError?) -> Void))
}
