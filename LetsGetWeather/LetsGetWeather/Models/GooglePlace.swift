//
//  GooglePlace.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 29/06/2024.
//

import Foundation
import GooglePlaces

struct GooglePlace: Codable {
    let name: String?
    let formattedAddress: String?
    let placeID: String?
    
    static public func map(place: GMSPlace?) -> GooglePlace {
        GooglePlace(
            name: place?.name,
            formattedAddress: place?.formattedAddress,
            placeID: place?.placeID
        )
    }
    
    
}
