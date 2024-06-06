//
//  WeatherNetworkService.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/22/24.
//

import Foundation

class WeatherNetworkService: WeatherService {
    
    static let instance = WeatherNetworkService()
    
    private init() {}
    
    func fetchCurrentWeatherInfo(
        url: String,
        completionHandler:@escaping (WeatherResponse?, String?) -> Void
    ) {
        guard let url = URL(string: url) else {
            completionHandler(nil, "Url parsing error!")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, "Something went wrong!\n\(error?.localizedDescription ?? "")")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(nil, "Invalid response received")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completionHandler(nil, "API calling error with code \(httpResponse.statusCode)")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completionHandler(result, nil)
                return
            } catch {
                completionHandler(nil, "Failed to convert to JSON: \(error)")
                return
            }
        }
        
        task.resume()
    }
}
