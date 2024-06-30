//
//  MockWeatherService.swift
//  LetsGetWeatherTests
//
//  Created by Dmytro Yaremyshyn on 30/06/2024.
//

import Foundation
import Combine
@testable import LetsGetWeather

class MockWeatherService: WeatherDataLoader {
    let shouldReturnError: Bool
    let shouldReturnAPIMessage: Bool

    init(shouldReturnError: Bool, shouldReturnAPIMessage: Bool) {
        self.shouldReturnError = shouldReturnError
        self.shouldReturnAPIMessage = shouldReturnAPIMessage
    }
    
    func loadData(from url: URL) -> WeatherDataLoader.Result {
        if shouldReturnError {
            return Fail(error: TestHelper.anyError).eraseToAnyPublisher()
        } else if shouldReturnAPIMessage {
            let response = TestHelper.anyErrorWeatherResponse
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            let response = TestHelper.anySuccessWeatherResponse
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
