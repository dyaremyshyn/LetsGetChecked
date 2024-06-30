//
//  WeatherLocalizationTests.swift
//  LetsGetWeatherTests
//
//  Created by Dmytro Yaremyshyn on 30/06/2024.
//

import XCTest

final class WeatherLocalizationTests: XCTestCase {

    func test_someLocalizedStrings() {
        // List of keys to test
        let keys = [
            "WEATHER_ALERT_TITLE",
            "WEATHER_SEARCH_PLACEHOLDER",
            "WEATHER_ALERT_WIND_DIRECTION",
            "WEATHER_GENERIC_CONNECTION_ERROR"
        ]

        let tableName = "Weather"

        for key in keys {
            // Get the localized string for the default language, this case "en"
            let localizedString = NSLocalizedString(
                key,
                tableName: tableName,
                bundle: Bundle.main,
                comment: ""
            )
            // Check that the string is not equal to the key itself
            XCTAssertNotEqual(localizedString, key, "Missing localized string for key: '\(key)' in table: '\(tableName)'")
        }
    }
}
