//
//  DataHandler.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 29/06/2024.
//

import Foundation

protocol StorageHandler {
    associatedtype DataType

    func saveData(_ data: DataType)
    func getData() -> DataType?
}
