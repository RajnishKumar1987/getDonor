//
//  LocationManager.swift
//  GetDonor
//
//  Created by Rajnish kumar on 24/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject,CLLocationManagerDelegate {
    
    static let sharedInstance = LocationManager()
    let locationManager = CLLocationManager()
    var latitude: String = "0.0"
    var longitude: String = "0.0"
    
    
    override init() {
       super.init()
    }
    
    func startLocaitonService() {
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.distanceFilter = 1
            locationManager.startUpdatingLocation()
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        if(String(locValue.longitude) != self.longitude){
            self.latitude = String(locValue.latitude)
            self.longitude = String(locValue.longitude)
            updateUserLocation()
        }
    }
    
    func updateUserLocation() {
        
        let apiLoader = APIRequestLoader(apiRequest: CommonApiRequest())
        let param: [String: String] = ["id": AppConfig.getUserId(), "lat":latitude, "lon":longitude]
        
        apiLoader.loadAPIRequest(forFuncion: .updateLocation, requestData: param) { (response, error) in
        }
        
    }
    
}





