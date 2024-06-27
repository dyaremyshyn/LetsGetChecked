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

    private let networkLoader: NetworkDataLoader
    private var cancellables = Set<AnyCancellable>()
    
    init(networkLoader: NetworkDataLoader) {
        self.networkLoader = networkLoader
    }
    
    var title: String {
        // will be replaced by Localized
        "Weather"
    }
    
    var searchPlaceholder: String {
        // will be replaced by Localized
        "Search City or Postal Code"
    }
    
    public func selected(place: GMSPlace?) {
        selectedPlace = place
    }
    
    public func select(place: String) {
        let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(Constants.weatherAPIKey)&q=\(place)")!
        
        networkLoader.loadData(from: url)
            .map(\.current)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    // Deal with error
                    print(error.localizedDescription)
                case .finished: ()
                }
            } receiveValue: { [weak self] current in
                guard let self else { return }
                appendReatrivedWeatherFor(current)
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
