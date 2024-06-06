//
//  WeatherService.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 6/3/24.
//

import Foundation

protocol WeatherService {
    func fetchCurrentWeatherInfo(
        url: String,
        completionHandler:@escaping (WeatherResponse?, String?) -> Void
    )
}
