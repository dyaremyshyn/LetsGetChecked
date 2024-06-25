//
//  WeatherResponse.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 25/06/2024.
//

import Foundation

public struct WeatherResponse: Decodable {
    let location: LocationModel?
    let current: CurrentModel?
    let code: Int?
    let message: String?
}
