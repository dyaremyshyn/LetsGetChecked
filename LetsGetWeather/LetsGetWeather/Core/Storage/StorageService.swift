//
//  StorageService.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 29/06/2024.
//

import Foundation

public struct StorageService: DataHandler {
    typealias DataType = [WeatherModel]
    
    static let dataKey = "weatherLocations"

    func saveData(_ data: [WeatherModel]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            UserDefaults.standard.set(encodedData, forKey: StorageService.dataKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getData() -> [WeatherModel]? {
        guard let data = UserDefaults.standard.data(forKey: StorageService.dataKey) else { return nil }
        
        do {
            let weatherLocations = try JSONDecoder().decode([WeatherModel].self, from: data)
            return weatherLocations
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
