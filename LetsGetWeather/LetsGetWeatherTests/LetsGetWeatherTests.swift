//
//  LetsGetWeatherTests.swift
//  LetsGetWeatherTests
//
//  Created by Dmytro Yaremyshyn on 25/06/2024.
//

import XCTest
import Combine
@testable import LetsGetWeather

final class LetsGetWeatherTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
    func testLoadWeatherWithError() {
        let sut = makeSUT(shouldReturnError: true, shouldReturnAPIMessage: false)
        let expectation = XCTestExpectation(description: "Load weather data fails")

        sut.loadData(from: TestHelper.anyURL)
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but got success")
                case .failure(let error):
                    XCTAssertEqual(error as NSError, TestHelper.anyError)
                    expectation.fulfill()
                }
            } receiveValue: { response in
                XCTFail("Expected failure, but got success with \(response)")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadWeatherWithErrorMessage() {
        let sut = makeSUT(shouldReturnError: false, shouldReturnAPIMessage: true)
        let expectation = XCTestExpectation(description: "Load weather data fails")

        sut.loadData(from: TestHelper.anyURL)
            .sink { completion in
                switch completion {
                case .finished: ()
                case.failure(_):
                    XCTFail("Expected success, but got failure")
                }
            } receiveValue: { response in
                XCTAssertEqual(response.error?.code, TestHelper.anyErrorWeatherResponse.error?.code)
                XCTAssertEqual(response.error?.message, TestHelper.anyErrorWeatherResponse.error?.message)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadWeatherWithSuccess() {
        let sut = makeSUT(shouldReturnError: false, shouldReturnAPIMessage: false)
        let expectation = XCTestExpectation(description: "Load weather data with success")

        sut.loadData(from: TestHelper.anyURL)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Expected success, but got failure with \(error)")
                case .finished: ()
                }
            }, receiveValue: { response in
                XCTAssertNotNil(TestHelper.anySuccessWeatherResponse.current)
                XCTAssertNotNil(TestHelper.anySuccessWeatherResponse.location)
                XCTAssertNil(TestHelper.anySuccessWeatherResponse.error)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Helpers

    private func makeSUT(shouldReturnError: Bool, shouldReturnAPIMessage: Bool, file: StaticString = #filePath, line: UInt = #line) -> WeatherDataLoader {
        let sut = MockWeatherAPICall(shouldReturnError: shouldReturnError, shouldReturnAPIMessage: shouldReturnAPIMessage)
        trackForMemoryLeaks(sut)
        return sut
    }
}
