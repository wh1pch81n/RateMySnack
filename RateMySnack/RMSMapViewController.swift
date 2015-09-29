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

class RMSMapViewController: UIViewController, LocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.sharedInstance.delegate = self
        
    }
    
    func displayLocation(location: CLLocation) {
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(0.05, 0.05)), animated: true)
        let locationPinCood = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPinCood
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        LocationManager.sharedInstance.reverseGeocodeLocationWithCoordinates(location) { (reverseGecodeInfo, placemark, error) -> Void in
            if let reverseInfo = reverseGecodeInfo
                , let address = reverseInfo["formattedAddress"] as? String
            {
                self.textField.text = address
            }
        }
    }
    
    func displayEnteredLocation(location: CLLocation) {
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(0.05, 0.05)), animated: true)
        
    }
    
    func getLocation() {
        LocationManager.sharedInstance.autoUpdate = true
        LocationManager.sharedInstance.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            print("\(latitude), \(longitude)")
            self.displayLocation(CLLocation(latitude: latitude, longitude: longitude))
            LocationManager.sharedInstance.stopUpdatingLocation()
        }
    }
    
    // MARK: LocationManager Delegate
    func locationFound(latitude:Double, longitude:Double) {
        
    }
    
    // MARK: Buttons
    @IBAction func updateCurrentLocationButtonTapped(sender: AnyObject) {
        getLocation()
    }
    
}