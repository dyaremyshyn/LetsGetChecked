//
//  WeatherComposer.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 26/06/2024.
//

import Foundation

public final class WeatherComposer {
    
    private init() {}
    
    public static func weatherComposedWith(networkLoader: NetworkDataLoader) -> WeatherViewController {
        let viewModel = WeatherViewModel(networkLoader: networkLoader)
        let viewController = WeatherViewController.makeWith(viewModel: viewModel)
        return viewController
    }
}

extension WeatherViewController {
    static func makeWith(viewModel: WeatherViewModel) -> WeatherViewController {
        let viewController = WeatherViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}