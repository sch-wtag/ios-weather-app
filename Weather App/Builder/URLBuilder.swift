//
//  URLBuilder.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 5/22/24.
//

import Foundation

class URLBuilder {
    private var lat: String?
    private var long: String?
    private var mode: Modes = Modes.json
    private var units: Units = Units.metric
    private var lang: String?
    
    func setLatLong(lat: String, long: String) -> URLBuilder {
        self.lat = lat
        self.long = long
        return self
    }
    
    func setMode(mode: Modes) -> URLBuilder {
        self.mode = mode
        return self
    }
    
    func setUnit(units: Units) -> URLBuilder {
        self.units = units
        return self
    }
    
    func setLang(lang: String) -> URLBuilder {
        self.lang = lang
        return self
    }
    
    func build() -> String {
        var url = "\(Constants.BASE_URL)/data/2.5/weather?"
        
        if lat != nil && long != nil {
            url += "lat=\(lat!)&lon=\(long!)"
        }
        
        url += "&appid=\(Constants.API_KEY ?? "")"
        
        if mode != Modes.json {
            url += "&mode=\(mode.rawValue)"
        }
        
        url += "&units=\(units.rawValue)"
        
        if lang != nil {
            url += "&lang=\(lang!)"
        }
        
        return url
    }
    
    enum Units: String {
        case metric = "metric"
        case standard = "standard"
        case imperial = "imperial"
    }
    
    enum Modes: String {
        case xml = "xml"
        case html = "html"
        case json = "json"
    }
}
