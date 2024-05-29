//
//  HomeViewModel.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/22/24.
//

import Foundation

class HomeViewModel {
    private let service = WeatherNetworkService()
    private let locationManager = LocationManager.instance
    
    private var response: WeatherResponse? = nil
    func getResponse() -> WeatherResponse? {
        return response
    }
    
    private var error: String? = nil
    func getError() -> String? {
        return error
    }
    
    func fetchCurrentWeatherInfo(
        completionHandler:@escaping ()->Void
    ) {
        locationManager.accessCurrentLocation() { lat, long in
            if lat != "" && long != "" {
                let url = URLBuilder()
                    .setLatLong(lat: lat, long: long)
                    .build()
                
                self.service.fetchCurrentWeatherInfo(url: url) { (response, error) in
                    if (error != nil) {
                        self.response = nil
                        self.error = error
                    } else {
                        self.response = response
                        self.error = nil
                    }
                    completionHandler()
                }
            } else {
                self.error = "Error fetching user's location"
            }
        }
    }
}
