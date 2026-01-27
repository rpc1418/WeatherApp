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
    
    @Published var locationUpdated: Location = Location(name: "", latitude: 0.0, longitude: 0.0, weather: .foggy)
    
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
            let weather = try await weatherService.fetchWeather(latitude: location.latitude, longitude: location.longitude)
            locationUpdated.temperature = "\(weather.daily.temperature2MMin.first.map { String(format: "%.f", $0) } ?? "--")\(weather.dailyUnits.temperature2MMin) to \(weather.daily.temperature2MMax.first.map { String(format: "%.f", $0) } ?? "--")\(weather.dailyUnits.temperature2MMax)"
            
            locationUpdated.uvIndex =
            weather.daily.uvIndexMax.first.map {
                String(format: "%.1f", $0)
            } ?? "--"+weather.dailyUnits.uvIndexMax

            locationUpdated.windSpeed =
            weather.daily.windSpeed10MMax.first.map {
                String(format: "%.0f", $0)
            } ?? "--" + weather.dailyUnits.windSpeed10MMax

            locationUpdated.rainSum =
            weather.daily.rainSum.first.map {
                "\($0)"
            } ?? "--" + weather.dailyUnits.rainSum

            locationUpdated.humidity =
            weather.daily.relativeHumidity2MMean.first.map {
                "\($0)"
            } ?? "--" + weather.dailyUnits.relativeHumidity2MMean

            locationUpdated.precipitationProbablity =
            weather.daily.precipitationProbabilityMean.first.map {
                "\($0)"
            } ?? "--" + weather.dailyUnits.precipitationProbabilityMean

            locationUpdated.sunrise =
            weather.daily.sunrise.first.map {
                String($0.suffix(5))
            } ?? "--"

            locationUpdated.sunset =
            weather.daily.sunset.first.map {
                String($0.suffix(5))
            } ?? "--"



        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
        
        isLoading = false
    }
}
