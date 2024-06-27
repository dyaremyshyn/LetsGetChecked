//
//  UIView+Container.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 27/06/2024.
//

import UIKit

extension UIView {

    public func makeContainer() -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        container.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
            
        return container
    }
}
