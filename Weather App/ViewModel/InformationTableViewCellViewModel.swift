//
//  InformationTableViewCellViewModel.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 6/5/24.
//

import Foundation

class InformationTableViewCellViewModel {
    var weatherData: WeatherResponse?
    
    init(weatherData: WeatherResponse?) {
        self.weatherData = weatherData
    }
}
