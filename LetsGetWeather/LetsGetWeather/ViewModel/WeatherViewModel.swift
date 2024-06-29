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
    @Published var selectedLocation: GooglePlace?
    @Published var errorMessage: String? = nil

    private let weatherLoader: WeatherDataLoader
    private let storageService: StorageService
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherLoader: WeatherDataLoader, storageService: StorageService) {
        self.weatherLoader = weatherLoader
        self.storageService = storageService
    }
    
    public func loadData() {
        guard let weatherLocations = storageService.getData() else { return }
        placesList = weatherLocations
    }
    
    public func selected(location: GooglePlace?) {
        selectedLocation = location
    }
    
    public func fetchWeatherFor(location: String?) {
        guard let url = URL(
            string:"\(WeatherAPIHelper.baseUrl)?key=\(Constants.APIKeys.weatherAPIKey)&q=\(location ?? "")&lang=\(LanguageCodes.getLanguage())"
        ) else { return }
                
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
        fetchedWeather = WeatherModel(
            selectedPlace: selectedLocation,
            current: model)
        
        if let index = placesList.firstIndex(where: { $0.selectedPlace?.placeID == selectedLocation?.placeID }) {
            placesList[index] = WeatherModel(selectedPlace: selectedLocation, current: model)
        } else {
            // Insert last searched location at top
            placesList.insert(WeatherModel(selectedPlace: selectedLocation, current: model), at: 0)
        }
        // Save data using UserDefaults
        saveData()
    }
    
    public func removeSearchedPlace(index: Int) {
        placesList.remove(at: index)
        // Update saved data
        saveData()
    }
    
    private func saveData() {
        storageService.saveData(placesList)
    }
}
