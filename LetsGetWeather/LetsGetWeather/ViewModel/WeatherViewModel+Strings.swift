//
//  WeatherViewModel+Strings.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 29/06/2024.
//

import Foundation

// MARK: Localized Strings
extension WeatherViewModel {
    public var alertTitle: String {
        "\(fetchedWeather?.selectedPlace?.name ?? "") \(weatherTitle)"
    }
    
    public var alertMessage: String {
        "\(temperature) \(fetchedWeather?.current?.tempC?.description ?? "")°C\n" +
        "\(condition) \(fetchedWeather?.current?.condition?.text ?? "")\n" +
        "\(humidity) \(fetchedWeather?.current?.humidity?.description ?? "")\n" +
        "\(windKm) \(fetchedWeather?.current?.windKph?.description ?? "")Kph\n" +
        "\(windDirection) \(fetchedWeather?.current?.windDir ?? "")\n" +
        "\(uv) \(fetchedWeather?.current?.uv?.description ?? "")\n" +
        "\(cloud) \(fetchedWeather?.current?.cloud?.description ?? "")"
    }
    
    public var alertCancel: String {
        NSLocalizedString(
            "WEATHER_ALERT_CANCEL",
            tableName: "Weather",
            bundle: .main,
            comment: "Cancel Alert Controller"
        )
    }
    
    private var weatherTitle: String {
        NSLocalizedString(
            "WEATHER_ALERT_TITLE",
            tableName: "Weather",
            bundle: .main,
            comment: "Weather"
        )
    }
    
    public var searchPlaceholder: String {
        NSLocalizedString(
            "WEATHER_SEARCH_PLACEHOLDER",
            tableName: "Weather",
            bundle: .main,
            comment: "Search Placeholder"
        )
    }
    
    public var servicerErrorMessage: String {
        NSLocalizedString(
            "WEATHER_GENERIC_CONNECTION_ERROR",
            tableName: "Weather",
            bundle: .main,
            comment: "Search Placeholder"
        )
    }
    
    public var autocompleteErrorMessage: String {
        NSLocalizedString(
            "WEATHER_AUTOCOMPLETE_ERROR",
            tableName: "Weather",
            bundle: .main,
            comment: "Search Placeholder"
        )
    }
    
    private var temperature: String {
        NSLocalizedString(
            "WEATHER_ALERT_TEMPERATURE",
            tableName: "Weather",
            bundle: .main,
            comment: "Temperature"
        )
    }
    
    private var condition: String {
        NSLocalizedString(
            "WEATHER_ALERT_CONDITION",
            tableName: "Weather",
            bundle: .main,
            comment: "Temperature"
        )
    }
   
    private var humidity: String {
        NSLocalizedString(
            "WEATHER_ALERT_HUMIDITY",
            tableName: "Weather",
            bundle: .main,
            comment: "Temperature"
        )
    }
    
    private var uv: String {
        NSLocalizedString(
            "WEATHER_ALERT_UV",
            tableName: "Weather",
            bundle: .main,
            comment: "Temperature"
        )
    }
    
    private var windKm: String {
        NSLocalizedString(
            "WEATHER_ALERT_WIND_KM",
            tableName: "Weather",
            bundle: .main,
            comment: "Temperature"
        )
    }
    
    private var windDirection: String {
        NSLocalizedString(
            "WEATHER_ALERT_WIND_DIRECTION",
            tableName: "Weather",
            bundle: .main,
            comment: "Temperature"
        )
    }
    
    private var cloud: String {
        NSLocalizedString(
            "WEATHER_ALERT_CLOUD",
            tableName: "Weather",
            bundle: .main,
            comment: "Temperature"
        )
    }
    
    public var tableHeaderTitle: String {
        NSLocalizedString(
            "WEATHER_TABLE_HEADER_TITLE",
            tableName: "Weather",
            bundle: .main,
            comment: "Temperature"
        )
    }
}
