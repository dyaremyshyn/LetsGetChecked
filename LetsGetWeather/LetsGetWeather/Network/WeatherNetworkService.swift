//
//  WeatherNetworkService.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 25/06/2024.
//

import Foundation

struct WeatherNetworkService: WeatherDataLoader {
    
    func loadData(from url: URL) -> WeatherDataLoader.Result {
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
