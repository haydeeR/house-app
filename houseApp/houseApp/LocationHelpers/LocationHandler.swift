//
//  LocationHandler.swift
//  houseApp
//
//  Created by Haydee Rodriguez on 4/24/18.
//  Copyright © 2018 Haydee Rodriguez. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    static var sharedInstance = LocationService()
    
    private lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return _locationManager
    }()
    fileprivate let defaultLocation = CLLocation.init(latitude: 29.175, longitude: -111.3583)
    fileprivate var returnLocation: (CLLocation) -> () = {_ in}
    fileprivate var currentLocation: CLLocation?
    
    //MARK: - Functions
    //MARK: Public functions
    func getLocation(completion: @escaping (CLLocation) -> ()) {
        if let currentLocation = currentLocation {
            completion(currentLocation)
            return
        }
        returnLocation = completion
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                updateCurrentLocation(newLocation: defaultLocation)
                break
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.requestLocation()
                break
            }
        } else {
            updateCurrentLocation(newLocation: defaultLocation)
        }
    }
    
    //MARK: Private functions
    fileprivate func updateCurrentLocation(newLocation: CLLocation) {
        currentLocation = newLocation
        returnLocation(currentLocation!)
    }
}


//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateCurrentLocation(newLocation: locations.last!)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateCurrentLocation(newLocation: defaultLocation)
    }
}
