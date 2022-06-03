//
//  DailyDTO.swift
//  WeatherApp
//
//  Created by Bartek Fira on 27/05/2022.
//

import Foundation

struct DailyDTO: Codable {
    let dt: Int
    let temp: TempTDO
    let weather: [WeatherDTO]
}

extension DailyDTO {
    var day: String {
        let date = Date(timeIntervalSince1970: dt.toDouble)
        return date.dayDate
    }
}
