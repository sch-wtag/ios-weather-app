//
//  MockHomeViewModelDataHelper.swift
//  Weather AppTests
//
//  Created by Sudipta Chowdhury on 6/5/24.
//

import Foundation
@testable import Weather_App

class MockHomeViewModelDataHelper {
    
    func getWeatherData() -> WeatherResponse {
        return WeatherResponse(
            coord: Coord(lon: 23.33, lat: 25.33),
            weather: [
            Weather(id: 1, main: "Sunny", description: "very sunny", icon: "sun.png")
            ],
            base: "base1",
            main: Main(temp: 23.5, feels_like: 30.3, temp_min: 18, temp_max: 30, pressure: 250, humidity: 17, sea_level: 150, grnd_level: 120),
            visibility: 200,
            wind: Wind(speed: 30.3, deg: 12, gust: 5.3),
            clouds: Clouds(all: 25),
            dt: 45,
            sys: Sys(type: 1, id: 1, country: "BD", sunrise: 14893600, sunset: 14893600),
            timezone: 25330,
            id: 1,
            name: "Dhaka",
            cod: 20
        )
    }
    
    func getErrorMsg() -> String {
        return "No connection error!"
    }
}
