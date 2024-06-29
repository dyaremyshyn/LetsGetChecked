//
//  LanguageCodes.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 29/06/2024.
//

import Foundation

enum LanguageCodes: String {
    case en
    case pt
    
    static func getLanguage() -> String {
        let langCode = Locale.current.languageCode
        return langCode?.contains("pt") ?? false ? LanguageCodes.pt.rawValue : LanguageCodes.en.rawValue
    }
}
