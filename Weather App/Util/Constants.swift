//
//  Constants.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/21/24.
//

import Foundation

struct Constants {
    static let splashAnimationTime = 1.5
    static let IMAGE_BASE_URL = "https://openweathermap.org/img/wn/"
    static let BASE_URL = "https://api.openweathermap.org/"
    static let API_KEY = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY")
}
