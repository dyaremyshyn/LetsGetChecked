//
//  ErrorWeather.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 29/06/2024.
//

import Foundation

struct ErrorWeather: Decodable {
    let code: Int?
    let message: String?
}
