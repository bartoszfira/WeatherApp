//
//  HourlyDTO.swift
//  WeatherApp
//
//  Created by Bartek Fira on 27/05/2022.
//

import Foundation

struct HourlyDTO: Codable {
    let dt: Int
    let temp: Float
    let weather: [WeatherDTO]
}

extension HourlyDTO {
    var getTime: String {
        let date = Date(timeIntervalSince1970: dt.toDouble)
        return date.houreMinuteDate
    }
}
