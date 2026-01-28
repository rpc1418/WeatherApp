//
//  WeatherService.swift
//  WeatherApp
//
//  Created by rentamac on 26/01/2026.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(latitude: Double, longitude: Double)
    async throws -> WeatherData
}

final class WeatherService: WeatherServiceProtocol {
    private let networkService: Networking
    
    init(networkService: Networking) {
        self.networkService = networkService
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherData {
        let request = WeatherRequest(latitude: latitude, longitude: longitude)
        
        let endpoint = WeatherEndpoint(request: request)

        let response: WeatherResponse = try await networkService.request(endpoint: endpoint, responseType: WeatherResponse.self)

        return WeatherData(response: response)
    }
}
