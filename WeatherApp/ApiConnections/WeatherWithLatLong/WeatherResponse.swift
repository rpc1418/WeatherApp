//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by rentamac on 26/01/2026.
//

import Foundation



// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let dailyUnits: DailyUnits
    let daily: Daily

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case dailyUnits = "daily_units"
        case daily
    }
}

// MARK: - Daily
struct Daily: Codable {
    let time: [String]
    let temperature2MMax, temperature2MMin, uvIndexMax, windSpeed10MMax: [Double]
    let rainSum: [Double]
    let relativeHumidity2MMean: [Int]
    let visibilityMean: [Double]
    let precipitationProbabilityMean: [Int]
    let sunset, sunrise: [String]
    let weatherCode: [Int]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case uvIndexMax = "uv_index_max"
        case windSpeed10MMax = "wind_speed_10m_max"
        case rainSum = "rain_sum"
        case relativeHumidity2MMean = "relative_humidity_2m_mean"
        case visibilityMean = "visibility_mean"
        case precipitationProbabilityMean = "precipitation_probability_mean"
        case sunset, sunrise
        case weatherCode = "weather_code"
        
    }
}

// MARK: - DailyUnits
struct DailyUnits: Codable {
    let time, temperature2MMax, temperature2MMin, uvIndexMax: String
    let windSpeed10MMax, rainSum, relativeHumidity2MMean, visibilityMean: String
    let precipitationProbabilityMean, sunset, sunrise, weatherCode: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case uvIndexMax = "uv_index_max"
        case windSpeed10MMax = "wind_speed_10m_max"
        case rainSum = "rain_sum"
        case relativeHumidity2MMean = "relative_humidity_2m_mean"
        case visibilityMean = "visibility_mean"
        case precipitationProbabilityMean = "precipitation_probability_mean"
        case sunset, sunrise
        case weatherCode = "weather_code"
    }
}


//Mark:- WeatherDataWraper
struct WeatherData {
    let response: WeatherResponse
    
    var uvIndex: String {
        response.daily.uvIndexMax.first.map { String(format: "%.1f", $0) } ?? "--" + response.dailyUnits.uvIndexMax
    }
    
    var windSpeed: String {
        response.daily.windSpeed10MMax.first.map { String(format: "%.0f", $0) } ?? "--" + response.dailyUnits.windSpeed10MMax
    }
    
    var rainSum: String {
        response.daily.rainSum.first.map { String(format: "%.1f", $0) } ?? "--" + response.dailyUnits.rainSum
    }

    
    var humidity: String {
        response.daily.relativeHumidity2MMean.first.map { "\($0)" } ?? "--" + response.dailyUnits.relativeHumidity2MMean
    }
    
    var precipitationProbablity: String {
        response.daily.precipitationProbabilityMean.first.map { "\($0)" } ?? "--" + response.dailyUnits.precipitationProbabilityMean
    }
    
    var sunrise: String {
        response.daily.sunrise.first.map { String($0.suffix(5)) } ?? "--"
    }
    
    var sunset: String {
        response.daily.sunset.first.map { String($0.suffix(5)) } ?? "--"
    }
    
    
    var temperature: String {
        let min = response.daily.temperature2MMin.first.map { String(format: "%.0f", $0) } ?? "--"
        let max = response.daily.temperature2MMax.first.map { String(format: "%.0f", $0) } ?? "--"
        let unit = response.dailyUnits.temperature2MMin
        return "\(min)\(unit) / \(max)\(unit)"
    }
    
    var weather: String {
        let code = response.daily.weatherCode.first ?? 0
        switch code {
        case 0: return "sun.max.fill"
        case 1...3: return "cloud.sun.fill"
        case 45, 48: return "cloud.fog.fill"
        case 51...55: return "cloud.drizzle.fill"
        case 61...65: return "cloud.rain.fill"
        case 71...75: return "cloud.snow.fill"
        case 80...82: return "cloud.heavyrain.fill"
        case 85, 86: return "cloud.sleet.fill"
        case 95...99: return "cloud.bolt.fill"
        default: return "cloud.fill"
        }
    }

}

