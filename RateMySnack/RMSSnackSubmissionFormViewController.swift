//
//  RMSSnackSubmissionFormViewController.swift
//  RateMySnack
//
//  Created by Maria Lopez on 9/11/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import UIKit

private let CONSTRAINT_FOR_BOTTOM_WHEN_NO_KEYBOARD = CGFloat(16)
private let CONSTRAINT_CHANGE_ANIMATION_TIME = NSTimeInterval(0.5)

enum RMSSubmissionFormError: ErrorType {
    case SnackName
    case SnackDescription
	case SnackRating
}

func keyboardFrameFrom(notification: NSNotification) -> CGRect? {
    return (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
}

class RMSSnackSubmissionFormViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var snackNameEntry: UITextField!
    @IBOutlet var snackDescription: UITextView!
	weak var snackRating: RMSStarViewController!
    @IBOutlet var submitButton: UIButton!
    
    override func viewDidLoad() {
        addKeyboardNotifications()
        
        // TODO: Subclass the submit button to have these attributes rather than congesting it here
        submitButton.layer.borderColor = UIColor.grayColor().CGColor
        submitButton.layer.borderWidth = 3
        submitButton.layer.cornerRadius = 12.0
    }
    
    func addKeyboardNotifications() {
        let keyboardNotification = { (notification: String, keyboardHeight: (h: CGFloat) -> ()) -> Void in
            NSNotificationCenter.defaultCenter().addObserverForName(notification, object: nil, queue: NSOperationQueue()) { (notification: NSNotification) -> Void in
                if let keyboardFrame = keyboardFrameFrom(notification) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        UIView.animateWithDuration(CONSTRAINT_CHANGE_ANIMATION_TIME, animations:{
                            keyboardHeight(h: keyboardFrame.height + CONSTRAINT_FOR_BOTTOM_WHEN_NO_KEYBOARD)
                            self.view.layoutIfNeeded()
                        })
                    })
                }
            }
        }
        
        keyboardNotification(UIKeyboardWillChangeFrameNotification) { self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: $0, right: 0) }
        keyboardNotification(UIKeyboardWillShowNotification) { self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: $0, right: 0) }
        keyboardNotification(UIKeyboardDidHideNotification) { _ in self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: CONSTRAINT_FOR_BOTTOM_WHEN_NO_KEYBOARD, right: 0) }
    }
    
    func cleanFormData() {
        let blanks = { (s: String) -> Bool in s != "" }
        
        var name = snackNameEntry.text ?? ""
        name = (name >% " \n").filter(blanks).joinWithSeparator(" ")
        snackNameEntry.text = name
        
        var description = snackDescription.text
        description = (description >% " ").filter(blanks).joinWithSeparator(" ")
        description = (description >% "\n").filter(blanks).joinWithSeparator("\n")
        snackDescription.text = description
    }
    
    func verifyFormData() throws {
        guard let s = snackNameEntry.text where s != ""  else {
            throw RMSSubmissionFormError.SnackName
        }
        if snackDescription.text == "" {
            throw RMSSubmissionFormError.SnackDescription
        }
		if snackRating.starRating == 0 {
			throw RMSSubmissionFormError.SnackRating
		}
    }
    
    
    @IBAction func tappedCancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tappedSubmitButton(sender: UIButton) {
        do {
            cleanFormData()
            try verifyFormData()
            let alertView = UIAlertView(title: "loading", message: nil, delegate: nil, cancelButtonTitle: nil)
            alertView.show()
			
			let snack = Snack(snackName: snackNameEntry.text!, snackDescription: snackDescription.text)
			let rating = snackRating.starRating
			
            BackendDelegate_SharedInstance().submit(snack, rating: rating) { (err) -> Void in
                alertView.dismissWithClickedButtonIndex(1, animated: false)
				self.dismissViewControllerAnimated(true, completion: nil)
            }
        } catch RMSSubmissionFormError.SnackName {
            incompleteSnackFormPopUpOn(self, withError: RMSSubmissionFormError.SnackName, didDismiss: { (UIAlertAction) -> () in
                
            })
        } catch RMSSubmissionFormError.SnackDescription {
            incompleteSnackFormPopUpOn(self, withError: RMSSubmissionFormError.SnackDescription, didDismiss: { (UIAlertAction) -> () in
            })
		}
		catch RMSSubmissionFormError.SnackRating {
			incompleteSnackFormPopUpOn(self, withError: RMSSubmissionFormError.SnackRating, didDismiss: { (UIAlertAction) -> () in
				
			})
        } catch {
            assertionFailure("Impossible Error")
        }
    }
	
	// MARK: Segue
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let vc = segue.destinationViewController as? RMSStarViewController {
			self.snackRating = vc
		}
	}
	
}

