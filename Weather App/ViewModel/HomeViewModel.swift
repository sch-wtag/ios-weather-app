//
//  HomeViewModel.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/22/24.
//

import Foundation

class HomeViewModel {
    
    private let service: WeatherService?
    
    init(service: WeatherService) {
        self.service = service
    }
    
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
        let lat = UserDefaults.standard.string(forKey: StringConstants.locationLatitude)
        let long = UserDefaults.standard.string(forKey: StringConstants.locationLongitude)
        
        if lat==nil || long==nil {
            self.error = "Error fetching user's location"
        } else {
            let url = URLBuilder()
                .setLatLong(lat: lat!, long: long!)
                .build()
            
            self.service?.fetchCurrentWeatherInfo(url: url) { (response, error) in
                if (error != nil) {
                    self.response = nil
                    self.error = error
                } else {
                    self.response = response
                    self.error = nil
                }
                completionHandler()
            }
        }
    }
}
