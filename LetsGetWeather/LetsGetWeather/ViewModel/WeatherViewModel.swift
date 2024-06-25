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
    @Published var selectedPlaces: [WeatherModel] = []
    @Published var selectedResult: GooglePlaceModel?
    @Published var searchResults: [GooglePlaceModel] = []

    private let networkLoader: NetworkDataLoader
    private var cancellables = Set<AnyCancellable>()
    
    init(networkLoader: NetworkDataLoader) {
        self.networkLoader = networkLoader
    }

    public func searchLocation(query: String) {
        GMSPlacesClient.shared().findAutocompletePredictions(
            fromQuery: query,
            filter: GMSAutocompleteFilter(),
            sessionToken: nil) { [weak self] (results, error) in
                guard let self, error == nil else {
                    print("Error finding predictions: \(error?.localizedDescription)")
                    return
                }
                print("\(results?.first?.attributedFullText.string) ; \(results?.first?.placeID)\n")
                self.searchResults = results?.compactMap {
                    GooglePlaceModel(name: $0.attributedFullText.string, id: $0.placeID)
                } ?? []
        }
    }
    
    var title: String {
        // will be replaced by Localized
        "Weather"
    }
    
    var searchPlaceholder: String {
        // will be replaced by Localized
        "Search City"
    }
    
    public func select(place: String) {
        let url = URL(string: "http://api.weatherapi.com/v1/current.json?key=\(Constants.weatherAPIKey)&q=\(place)")!
        
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
                self.selectedPlaces.append(WeatherModel(selectedPlace: selectedResult, current: current))
            }
            .store(in: &cancellables)
    }
}
