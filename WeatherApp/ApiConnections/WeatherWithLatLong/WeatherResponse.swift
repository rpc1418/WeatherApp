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
    let rainSum, relativeHumidity2MMean: [Int]
    let visibilityMean: [Double]
    let precipitationProbabilityMean: [Int]
    let sunset, sunrise: [String]

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
    }
}

// MARK: - DailyUnits
struct DailyUnits: Codable {
    let time, temperature2MMax, temperature2MMin, uvIndexMax: String
    let windSpeed10MMax, rainSum, relativeHumidity2MMean, visibilityMean: String
    let precipitationProbabilityMean, sunset, sunrise: String

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
    }
}
