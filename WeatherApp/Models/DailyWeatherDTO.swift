//
//  DailyWeatherDTO.swift
//  WeatherApp
//
//  Created by Bartek Fira on 27/05/2022.
//

import Foundation
import MapKit

struct DailyWeatherDTO: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: CurrentDTO
    let hourly: [HourlyDTO]
    let daily: [DailyDTO]
}

extension DailyWeatherDTO {
    var location: CLLocationCoordinate2D? {
        return .init(latitude: lat, longitude: lon)
    }
}
