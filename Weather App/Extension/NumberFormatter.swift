//
//  NumberFormatter.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/28/24.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toCelciusFormat() -> String {
        return "\(self.rounded(toPlaces: 1))°C"
    }
}
