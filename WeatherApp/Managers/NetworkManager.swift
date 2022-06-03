//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Bartek Fira on 26/05/2022.
//

import Foundation

class NetworkManager {
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
