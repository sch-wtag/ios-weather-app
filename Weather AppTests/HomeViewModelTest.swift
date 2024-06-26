//
//  HomeViewModelTest.swift
//  Weather AppTests
//
//  Created by Sudipta Chowdhury on 6/5/24.
//

import XCTest
@testable import Weather_App

final class HomeViewModelTest: XCTestCase {
    
    var viewModel: HomeViewModel!
    var dataHelper: MockHomeViewModelDataHelper!
    var mockService: MockWeatherService!

    override func setUpWithError() throws {
        dataHelper = MockHomeViewModelDataHelper()
        mockService = MockWeatherService()
        viewModel = HomeViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        dataHelper = nil
        mockService = nil
    }
    
    func test_fetchCurrentWeatherInfo_returns_data() {
        mockService.data = dataHelper.getWeatherData()
        mockService.error = nil
        
        viewModel.fetchCurrentWeatherInfo {}
        
        XCTAssertNil(viewModel.getError())
        XCTAssertEqual(viewModel.getResponse()?.coord?.lon, 23.33)
    }
    
    func test_fetchCurrentWeatherInfo_returns_error() {
        mockService.data = nil
        mockService.error = dataHelper.getErrorMsg()
        
        viewModel.fetchCurrentWeatherInfo {}
        
        XCTAssertNil(viewModel.getResponse())
        XCTAssertEqual(viewModel.getError(), "No connection error!")
    }
}
