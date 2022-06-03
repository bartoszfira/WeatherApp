//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Bartek Fira on 02/06/2022.
//

import Foundation

extension Date {
    static let dayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "E"
        return dateFormatter
    }()

    var dayDate: String {
        return Date.dayDateFormatter.string(from: self)
    }

    static let houreMinuteDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()

    var houreMinuteDate: String {
        return Date.houreMinuteDateFormatter.string(from: self)
    }
}

