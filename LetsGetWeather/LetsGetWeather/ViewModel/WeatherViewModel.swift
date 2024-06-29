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
    @Published var selectedLocation: GMSPlace?
    @Published var errorMessage: String? = nil

    private let weatherLoader: WeatherDataLoader
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherLoader: WeatherDataLoader) {
        self.weatherLoader = weatherLoader
    }
    
    public func selected(location: GMSPlace?) {
        selectedLocation = location
    }
    
    public func fetchWeatherFor(location: String?) {
        guard let location = location else { return }
        
        let url = URL(string:"\(WeatherAPIHelper.baseUrl)?key=\(Constants.APIKeys.weatherAPIKey)&q=\(location)&lang=\(LanguageCodes.getLanguage())")!
        
        weatherLoader.loadData(from: url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(_):
                    self.errorMessage = self.servicerErrorMessage
                case .finished: ()
                }
            } receiveValue: { [weak self] weatherResponse in
                guard let self, weatherResponse.error == nil else {
                    self?.errorMessage = weatherResponse.error?.message
                    return
                }
                appendReatrivedWeatherFor(weatherResponse.current)
                self.errorMessage = nil
            }
            .store(in: &cancellables)
    }
    
    private func appendReatrivedWeatherFor(_ model: CurrentModel?) {
        fetchedWeather = WeatherModel(selectedPlace: selectedLocation, current: model)
        if placesList.filter({ $0.selectedPlace?.placeID == selectedLocation?.placeID }).count == 0 {
            placesList.insert(WeatherModel(selectedPlace: selectedLocation, current: model), at: 0) // Insert last searched at top 
        }
    }
}
