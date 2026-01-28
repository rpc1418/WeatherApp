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
    
//    @Published var temperature: String = "--"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private var prCon = PersistenceController.shared
//    @Published var locationUpdated: Location = Location(name: "", latitude: 0.0, longitude: 0.0, weather: .foggy)
//    @Published var locationUpdated: Location? = nil
    
    private let weatherService: WeatherService
    
    init() {
        let  networkService = HttpNetworking()
        let weatherService = WeatherService(networkService: networkService)
        self.weatherService = weatherService
    }
    
    func loadWeather(location: Location) async    {
        
        isLoading = true
        errorMessage = nil
        
        do {
            print(location.latitude , location.longitude)
            let curWeather = try await weatherService.fetchWeather(latitude: location.latitude, longitude: location.longitude)
            prCon.updateLocation(location: location, weatherinfo: curWeather)
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
        isLoading = false
    }
    
    func timeUpdatedLast(location: Location) -> Double{
        return Date().timeIntervalSince(location.lastUpdated ?? Date())
    }
}
