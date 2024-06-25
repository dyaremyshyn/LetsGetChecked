//
//  LocationModel.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 25/06/2024.
//

import Foundation

struct LocationModel: Decodable {
    let name: String?
    let region: String?
    let country: String?
    let lat: Double?
    let lon: Double?
    let localtime: String?
}
