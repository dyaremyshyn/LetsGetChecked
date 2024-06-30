//
//  MockStorageService.swift
//  LetsGetWeatherTests
//
//  Created by Dmytro Yaremyshyn on 30/06/2024.
//

import Foundation
@testable import LetsGetWeather

class MockStorageService: StorageHandler {
    typealias DataType = [WeatherModel]
    static let mockKey = "mockKey"
    
    let mockDefaults: UserDefaults
    
    init(mockDefaults: UserDefaults = .standard) {
        self.mockDefaults = mockDefaults
    }
    
    func saveData(_ data: [WeatherModel]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            mockDefaults.set(encodedData, forKey: MockStorageService.mockKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getData() -> [WeatherModel]? {
        guard let data = mockDefaults.data(forKey: MockStorageService.mockKey) else { return nil }
        
        do {
            let weatherLocations = try JSONDecoder().decode([WeatherModel].self, from: data)
            return weatherLocations
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
