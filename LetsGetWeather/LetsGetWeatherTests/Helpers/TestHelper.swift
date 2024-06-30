//
//  TestHelper.swift
//  LetsGetWeatherTests
//
//  Created by Dmytro Yaremyshyn on 30/06/2024.
//

import Foundation
@testable import LetsGetWeather

struct TestHelper {
    
    static var anyError: NSError {
        NSError(domain: "TestError", code: 999, userInfo: nil)
    }
    
    static var anyURL: URL {
        URL(string: "www.any-url.com")!
    }
    
    static var anySuccessWeatherResponse: WeatherResponse {
        WeatherResponse(
            location: LocationModel(name: "", region: nil, country: nil, lat: nil, lon: nil, localtime: nil),
            current: CurrentModel(
                lastUpdated: nil,
                tempC: 20.0,
                tempF: 60.0,
                isDay: 1,
                condition: ConditionModel(text: "Sunny", icon: nil),
                windMph: 10.1,
                windKph: 10.1,
                windDegree: nil,
                windDir: "S",
                pressureMb: nil,
                pressureIn: nil,
                precipMm: nil,
                precipIn: nil,
                humidity: 5,
                cloud: 50,
                feelslikeC: nil,
                feelslikeF: nil,
                visKm: nil,
                visMiles: nil,
                uv: 2.2,
                gustMph: nil,
                gustKph: nil
            ),
            error: nil)
    }
    
    static var anyErrorWeatherResponse: WeatherResponse {
        WeatherResponse(location: nil, current: nil, error: ErrorWeather(code: 10, message: "Missing location parameter"))
    }
}
