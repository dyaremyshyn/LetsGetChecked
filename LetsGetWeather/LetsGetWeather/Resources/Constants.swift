//
//  Constants.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 25/06/2024.
//
// Credits to Toomas Vahter and his article 
// https://augmentedcode.io/2023/11/27/using-on-demand-resources-for-securely-storing-api-keys-in-ios-apps/
// Storing API keys securely in Swift is essential to protect the application, users, and data.

import Foundation

enum Constants {
    
    static func loadAPIKeys() async throws {
        let request = NSBundleResourceRequest(tags: ["APIKeys"])
        try await request.beginAccessingResources()

        let url = Bundle.main.url(forResource: "APIKeys", withExtension: "json")!
        let data = try Data(contentsOf: url)

        APIKeys.storage = try JSONDecoder().decode([String: String].self, from: data)

        request.endAccessingResources()
    }

    public enum APIKeys {
        static fileprivate(set) var storage = [String: String]()

        static var weatherAPIKey: String { storage["weatherAPIKey"] ?? "" }
        static var googleAPIKey: String { storage["googleAPIKey"] ?? "" }
    }
}
