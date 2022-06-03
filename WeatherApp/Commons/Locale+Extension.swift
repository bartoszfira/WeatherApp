//
//  Locale+Extension.swift
//  WeatherApp
//
//  Created by Bartek Fira on 02/06/2022.
//

import Foundation

extension Locale {
    static var preferredLanguageCode: String {
        guard let preferredLanguage = preferredLanguages.first,
              let code = Locale(identifier: preferredLanguage).languageCode else {
            return "en"
        }

        return code
    }
}
