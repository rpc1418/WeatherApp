//
//  DetailViewModel.swift
//  WeatherApp
//
//  Created by rentamac on 26/01/2026.
//

import Foundation
import Combine

@MainActor
final class DetailsViewModel: ObservableObject{
    
    @Published var temperature: String = "--"
    @Published var discription: String = "--"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let weatherService: WeatherService
    
    init() {
        let  networkService = HttpNetworking()
        let weatherService = WeatherService(networkService: networkService)
        self.weatherService = weatherService
    }
    
    func loadWeather(latitude: Double, longitude: Double) async    {
        
        isLoading = true
        errorMessage = nil
        
        do {
            let weather = try await weatherService.fetchWeather(latitude: latitude, longitude: longitude)
            temperature = "\(weather.current.temperature2M)\(weather.currentUnits.temperature2M)"

        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
        
        isLoading = false
    }
}
