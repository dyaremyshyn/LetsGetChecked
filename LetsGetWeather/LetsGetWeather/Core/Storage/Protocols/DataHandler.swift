//
//  DataHandler.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 29/06/2024.
//

import Foundation

protocol DataHandler {
    associatedtype DataType

    func saveData(_ data: DataType)
    func getData() -> DataType?
}
