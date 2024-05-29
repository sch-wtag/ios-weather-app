//
//  LocationManager.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/22/24.
//

import Foundation
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    static let instance = LocationManager()
    
    var location: (String, String)->Void = {lat, long in }
    
    func accessCurrentLocation(
        completion: @escaping (String, String)->Void
    ) {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.location = completion
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            locationManager.requestAlwaysAuthorization()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            print("unknown authorization status")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location(String(location.coordinate.latitude), String(location.coordinate.longitude))
    }
}
