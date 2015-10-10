//
//  RMSMapPicker.swift
//  RateMySnack
//
//  Created by S. Han on 9/27/15.
//  Copyright © 2015 Ho, Derrick. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class RMSMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayLocation(location: CLLocation) {
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        LocationManager.sharedInstance.reverseGeocodeLocationWithCoordinates(location) { (reverseGecodeInfo, placemark, error) -> Void in
            if let reverseInfo = reverseGecodeInfo,
                let address = reverseInfo["formattedAddress"] as? String
            {
                self.textField.text = address
            }
        }
    }
    
    func displayEnteredAdress(address: String) {
        LocationManager.sharedInstance.geocodeAddressString(address: address) { (geocodeInfo, placemark, error) -> Void in
            if let geocodeInfo = geocodeInfo {
                guard let lattitude = CLLocationDegrees(geocodeInfo["latitude"] as! String),
                let longtitude = CLLocationDegrees(geocodeInfo["longtitude"] as! String)
                    else {
                        //Handle problem
                        return
                }
                self.displayLocation(CLLocation(latitude: lattitude, longitude: longtitude))
            }
        }
    }

    func getLocation() {
        LocationManager.sharedInstance.autoUpdate = true
        LocationManager.sharedInstance.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            print("\(latitude), \(longitude)")
            self.displayLocation(CLLocation(latitude: latitude, longitude: longitude))
            LocationManager.sharedInstance.stopUpdatingLocation()
        }
    }
    
    // MARK: Buttons
    @IBAction func updateCurrentLocationButtonTapped(sender: AnyObject) {
        getLocation()
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func tappedSearchAddressButton(sender: AnyObject) {
        if let t = textField.text {
            displayEnteredAdress(t)
        }
    }
    
    
}