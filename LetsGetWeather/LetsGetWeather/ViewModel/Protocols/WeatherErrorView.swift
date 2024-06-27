//
//  WeatherErrorView.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 28/06/2024.
//

import Foundation

public protocol WeatherErrorView {
    func display(errorMessage: String?)
}
