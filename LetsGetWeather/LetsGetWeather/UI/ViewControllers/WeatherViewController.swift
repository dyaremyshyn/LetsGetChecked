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
        
    var cancellables = Set<AnyCancellable>()
    var viewModel: WeatherViewModel? {
        didSet { bind() }
    }
    
    
    // MARK: Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func bind() {
        
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

// Google Place integration with the view
extension WeatherViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    private func addSearchBarToNavigationItem() {
        navigationItem.titleView = searchController.searchBar
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
    }
    
    public func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController.isActive = false
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place id: \(place.placeID)")
        searchController.searchBar.text = place.formattedAddress
    }
    
    public func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: any Error) {
        
    }
}
