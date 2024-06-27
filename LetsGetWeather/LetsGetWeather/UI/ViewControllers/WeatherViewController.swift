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
    
    lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        viewModel?.$placesList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] results in self?.tableView.reloadData() }
            .store(in: &cancellables)
        
        viewModel?.$fetchedWeather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                guard let self, let weather = weather else { return }
                self.showAlert(for: weather)
            }
            .store(in: &cancellables)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = viewModel?.title

        addSearchBarToNavigationItem()
        
        tableView.register(WeatherViewCell.self, forCellReuseIdentifier: WeatherViewCell.identifier)
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func showAlert(for weather: WeatherModel) {
        let temperatureText = "Temperature: \(weather.current?.tempC?.description ?? "not found")°C\n"
        let conditionText = "Condition: \(weather.current?.condition?.text ?? "not found")\n"
        let humidityText = "Humidity: \(weather.current?.humidity?.description ?? "not found")"
        
        let alert = UIAlertController(
            title: "\(viewModel?.selectedPlace?.name ?? "") Weather",
            message: temperatureText + conditionText + humidityText ,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func search() {
        guard let place = searchController.searchBar.text else { return }
        viewModel?.select(place: place)
    }
    
}

// MARK: Google Place API Integration
extension WeatherViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    private func addSearchBarToNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(search))

        navigationItem.titleView = searchController.searchBar
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
    }
    
    public func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController.isActive = false
        searchController.searchBar.text = place.formattedAddress
        viewModel?.selected(place: place)
    }
    
    public func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: any Error) {
        
    }
}

extension WeatherViewController {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.placesList.count ?? 0
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherViewCell.identifier, for: indexPath) as? WeatherViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = viewModel?.placesList[indexPath.row].selectedPlace?.formattedAddress
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = viewModel?.placesList[indexPath.row]
        viewModel?.select(place: selectedLocation?.selectedPlace?.formattedAddress ?? "")
        viewModel?.selected(place: selectedLocation?.selectedPlace)

    }
}
