//
//  CurrentModel.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 25/06/2024.
//

import Foundation

struct CurrentModel: Decodable {
    let lastUpdated: String?
    let tempC: Double?
    let tempF: Double?
    let condition: ConditionModel?
    let windMph: Double?
    let windKph: Double?
    let humidity: Double?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition = "condition"
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case humidity = "humidity"
    }
}
