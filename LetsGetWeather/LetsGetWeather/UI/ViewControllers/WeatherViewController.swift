//
//  WeatherViewController.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 25/06/2024.
//

import UIKit
import Combine
import GooglePlaces

public class WeatherViewController: UITableViewController {
    
    lazy var resultsViewController: GMSAutocompleteResultsViewController = {
        let viewController = GMSAutocompleteResultsViewController()
        viewController.delegate = self
        return viewController
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.searchResultsUpdater = resultsViewController
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = viewModel?.searchPlaceholder
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
        
    private var cancellables = Set<AnyCancellable>()
    var viewModel: WeatherViewModel? {
        didSet { bind() }
    }
    
    // MARK: Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func bind() {
        
        viewModel?.$fetchedWeather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                guard let weather = weather else { return }
                let alert = UIAlertController(title: "Weather", message: "Temperature: \(weather.current?.tempC)°C\nCondition: \(weather.current?.condition?.text)\nHumidity: \(weather.current?.humidity)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = viewModel?.title

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(search))
        
        addSearchBarToNavigationItem()
    }
    
    
    @objc func search() {
        guard let place = searchController.searchBar.text else { return }
        viewModel?.select(place: place)
    }
    
}

// MARK: Google Place API Integration
extension WeatherViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    private func addSearchBarToNavigationItem() {
        navigationItem.titleView = searchController.searchBar
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
    }
    
    public func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController.isActive = false
        searchController.searchBar.text = place.formattedAddress
        
    }
    
    public func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: any Error) {
        
    }
}
