//
//  WeatherViewCell.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 27/06/2024.
//

import Foundation
import UIKit

class WeatherViewCell: UITableViewCell {

    static let identifier = String(describing: WeatherViewCell.self)
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var detailedLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 50)
        label.textColor = .white
        return label
    }()
    
    lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(locationLabel)
        backgroundImageView.addSubview(temperatureLabel)
        backgroundImageView.addSubview(conditionLabel)
        backgroundImageView.addSubview(detailedLocationLabel)
        backgroundImageView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(humidityLabel)
        horizontalStackView.addArrangedSubview(windLabel)
                
        backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 8).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -8).isActive = true
        temperatureLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true

        locationLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 8).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 8).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: 8).isActive = true
        
        detailedLocationLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5).isActive = true
        detailedLocationLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 8).isActive = true
        detailedLocationLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: 8).isActive = true

        conditionLabel.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -8).isActive = true
        conditionLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 8).isActive = true
        
        horizontalStackView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -8).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -8).isActive = true
    }
    
    public func updateCell(model: WeatherModel?) {
        locationLabel.text = model?.selectedPlace?.name
        detailedLocationLabel.text = model?.selectedPlace?.formattedAddress
        temperatureLabel.text = "\(model?.current?.tempC?.description ?? "")º"
        conditionLabel.text = model?.current?.condition?.text ?? ""
        humidityLabel.text = "H: \(model?.current?.humidity?.description ?? "")"
        windLabel.text = "W:\(model?.current?.windKph?.description ?? "")Kph"
        
        backgroundImageView.image = WeatherConditionsHelper.getBackgroundImageFor(model: model?.current)
    }
}
