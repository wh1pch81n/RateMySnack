//
//  ViewController.swift
//  BackendServer
//
//  Created by Derrick  Ho on 7/18/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BESViewController: UIViewController, LocationManagerDelegate, CLLocationManagerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var currentLocationTextfield: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var coreLocationManager = CLLocationManager()
    var locationManager: LocationManager!
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        coreLocationManager.delegate = self
        self.locationManager = LocationManager.sharedInstance
        self.coreLocationManager.requestAlwaysAuthorization()
        let authorizationCode = CLLocationManager.authorizationStatus()
        if authorizationCode == CLAuthorizationStatus.NotDetermined && coreLocationManager.respondsToSelector("requestAlwaysAuthorization") {
            if NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil {
                coreLocationManager.requestAlwaysAuthorization()
            } else {
                print("No description provided")
            }
            
        } else {
         self.getLocation()
        }
        
        successPopUpOn(self) { (UIAlertAction) -> () in  print("cow a bunga") }

        BESInterface.retrieve { (objs: [SnackProtocol], err: RMSBackendError?) -> Void in

            if err == nil {
                for i in objs { // looping though each object *i* in the array *objs*
                    print(i.snackName, terminator: "")
                    print(",")
                }
            } else {
                print(err)
            }
        }
        
        let sn = "redpenny"
        BESInterface.submit(Snack(name: sn, description: ""), completionHandler: { (err: RMSBackendError?) -> Void in
            if err == nil {
                print("snack \(sn) saved")
            } else if err == .Duplication {
                print("Already has \(sn)")
            }
        })
    }
    
    func displayLocation(location: CLLocation) {
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(0.05, 0.05)), animated: true)
        let locationPinCood = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPinCood
        
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        self.locationManager.reverseGeocodeLocationWithCoordinates(location) { (reverseGecodeInfo, placemark, error) -> Void in
            let address = reverseGecodeInfo?.objectForKey("formattedAddress") as! String
            self.currentLocationTextfield.text = address
        }
    }
    
    func displayEnteredLocation(location: CLLocation) {
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(0.05, 0.05)), animated: true)
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
        if status != CLAuthorizationStatus.NotDetermined || status != CLAuthorizationStatus.Denied || status != CLAuthorizationStatus.Restricted {
            getLocation()
        }
    }
    
    func getLocation() {
        self.locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            self.displayLocation(CLLocation(latitude: latitude, longitude: longitude))
        }
    }
    
    func locationFound(latitude:Double, longitude:Double){
    }
    
    @IBAction func updateCurrentLocationButtonTapped(sender: AnyObject) {
        getLocation()
    }
    
    
}

