//
//  CurrentDTO.swift
//  WeatherApp
//
//  Created by Bartek Fira on 27/05/2022.
//

import Foundation

struct CurrentDTO: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let feels_like: Float
    let pressure: Int
    let humidity: Int
    let dew_point: Float
    let uvi: Float
    let clouds: Int
    let visibility: Int
    let wind_speed: Float
    let wind_deg: Int
    let temp: Float
    let weather: [WeatherDTO]
}
