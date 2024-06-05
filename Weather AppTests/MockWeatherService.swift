//
//  MockWeatherService.swift
//  Weather AppTests
//
//  Created by Sudipta Chowdhury on 6/5/24.
//

import Foundation
@testable import Weather_App

class MockWeatherService: WeatherService {
    
    var data: WeatherResponse!
    var error: String!
    
    func fetchCurrentWeatherInfo(url: String, completionHandler: @escaping (Weather_App.WeatherResponse?, String?) -> Void) {
        completionHandler(data, error)
    }
}
