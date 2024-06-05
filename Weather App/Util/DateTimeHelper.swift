//
//  DateTimeHelper.swift
//  Weather App
//
//  Created by Sudipta Chowdhury on 6/5/24.
//

import Foundation

class DateTimeHelper {
    static func convertToDateTimeFromTimeStamp(timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let dateFormatter = DateFormatter()
        let timeZone = TimeZone.current.abbreviation() ?? "BST"
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}
