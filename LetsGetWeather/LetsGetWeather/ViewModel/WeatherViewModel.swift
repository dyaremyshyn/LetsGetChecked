//
//  WeatherViewModel.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 25/06/2024.
//

import Foundation
import Combine
import GooglePlaces

class WeatherViewModel: ObservableObject {
    @Published var fetchedWeather: WeatherModel?
    @Published var placesList: [WeatherModel] = []
    @Published var selectedPlace: GMSPlace?
    @Published var errorMessage: String? = nil

    private let networkLoader: NetworkDataLoader
    private var cancellables = Set<AnyCancellable>()
    
    init(networkLoader: NetworkDataLoader) {
        self.networkLoader = networkLoader
    }
    
    var alertTitle: String {
        NSLocalizedString(
            "WEATHER_ALERT_TITLE",
            tableName: "Weather",
            bundle: .main,
            comment: "Alert Controller title"
        )
    }
    
    var searchPlaceholder: String {
        NSLocalizedString(
            "WEATHER_SEARCH_PLACEHOLDER",
            tableName: "Weather",
            bundle: .main,
            comment: "Search Placeholder"
        )
    }
    
    var servicerErrorMessage: String {
        NSLocalizedString(
            "WEATHER_GENERIC_CONNECTION_ERROR",
            tableName: "Weather",
            bundle: .main,
            comment: "Search Placeholder"
        )
    }
    
    public func selected(place: GMSPlace?) {
        selectedPlace = place
    }
    
    public func select(place: String) {
        let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(Constants.weatherAPIKey)&q=\(place)")!
        
        networkLoader.loadData(from: url)
            .map(\.current)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(_):
                    self.errorMessage = self.servicerErrorMessage
                case .finished: ()
                }
            } receiveValue: { [weak self] current in
                guard let self else { return }
                appendReatrivedWeatherFor(current)
                self.errorMessage = nil
            }
            .store(in: &cancellables)
    }
    
    private func appendReatrivedWeatherFor(_ model: CurrentModel?) {
        fetchedWeather = WeatherModel(selectedPlace: selectedPlace, current: model)
        if placesList.filter({ $0.selectedPlace?.placeID == selectedPlace?.placeID }).count == 0 {
            placesList.append(WeatherModel(selectedPlace: selectedPlace, current: model))
        }
    }
}
