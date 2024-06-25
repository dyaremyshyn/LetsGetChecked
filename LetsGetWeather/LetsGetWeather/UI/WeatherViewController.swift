//
//  WeatherViewController.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 25/06/2024.
//

import UIKit
import Combine

class WeatherViewController: UITableViewController {
    
    var cancellables = Set<AnyCancellable>()
    var viewModel: WeatherViewModel? {
        didSet { bind() }
    }
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.tintColor = .systemGray
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func bind() {
        
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        title = viewModel?.title
        searchBar.placeholder = viewModel?.searchPlaceholder

        navigationItem.titleView = searchBar

        
    }
}
