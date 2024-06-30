//
//  StorageServiceTests.swift
//  LetsGetWeatherTests
//
//  Created by Dmytro Yaremyshyn on 30/06/2024.
//

import XCTest
@testable import LetsGetWeather

final class StorageServiceTests: XCTestCase {
    var mockUserDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        mockUserDefaults = UserDefaults(suiteName: "MockUserDefaults")
    }

    override func tearDown() {
        mockUserDefaults.removePersistentDomain(forName: "MockUserDefaults")
        mockUserDefaults = nil
        super.tearDown()
    }
    
    func testSaveData() {
        let sut = makeSUT(mockDefaults: mockUserDefaults)
        
        sut.saveData(TestHelper.weatherSavedList)
        
        // Retrieve data from mockUserDefaults directly
        if let savedData = mockUserDefaults.data(forKey: MockStorageService.mockKey) {
            do {
                let decodedData = try JSONDecoder().decode([WeatherModel].self, from: savedData)
                XCTAssertEqual(decodedData.count, TestHelper.weatherSavedList.count)
                XCTAssertEqual(decodedData.first?.selectedPlace?.name, TestHelper.weatherSavedList.first?.selectedPlace?.name)
                XCTAssertEqual(decodedData.first?.selectedPlace?.placeID, TestHelper.weatherSavedList.first?.selectedPlace?.placeID)
            } catch {
                XCTFail("Decoding failed: \(error.localizedDescription)")
            }
        } else {
            XCTFail("No data was saved to UserDefaults")
        }
    }

    
    func testGetData() {
        let sut = makeSUT(mockDefaults: mockUserDefaults)
        
        do {
            let encodedData = try JSONEncoder().encode(TestHelper.weatherSavedList)
            mockUserDefaults.set(encodedData, forKey: MockStorageService.mockKey)
        } catch {
            XCTFail("Encoding failed: \(error.localizedDescription)")
        }
        
        let savedData = sut.getData()
        
        XCTAssertEqual(savedData?.count, TestHelper.weatherSavedList.count)
        XCTAssertEqual(savedData?.first?.selectedPlace?.name, TestHelper.weatherSavedList.first?.selectedPlace?.name)
        XCTAssertEqual(savedData?.first?.selectedPlace?.placeID, TestHelper.weatherSavedList.first?.selectedPlace?.placeID)
    }
    
    
    // MARK: - Helpers

    private func makeSUT(mockDefaults: UserDefaults, file: StaticString = #filePath, line: UInt = #line) -> MockStorageService {
        let sut = MockStorageService(mockDefaults: mockDefaults)
        trackForMemoryLeaks(sut)
        return sut
    }
}
