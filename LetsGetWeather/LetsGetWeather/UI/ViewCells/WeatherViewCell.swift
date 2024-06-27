//
//  WeatherViewCell.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 27/06/2024.
//

import Foundation
import UIKit

class WeatherViewCell: UITableViewCell {

    static let identifier = "WeatherViewCell"
    private var model: WeatherModel?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
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
        
        contentView.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    public func updateCell(model: WeatherModel){
        self.model = model
        titleLabel.text = model.selectedPlace?.formattedAddress
    }
}
