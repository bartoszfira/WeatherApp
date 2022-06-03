//
//  WeatherDTO.swift
//  WeatherApp
//
//  Created by Bartek Fira on 27/05/2022.
//

import Foundation

struct WeatherDTO: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
