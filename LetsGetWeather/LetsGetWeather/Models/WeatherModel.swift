//
//  WeatherModel.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 25/06/2024.
//

import Foundation
import GooglePlaces

struct WeatherModel {
    let selectedPlace: GMSPlace?
    let current: CurrentModel?
}
