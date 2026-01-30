//
//  LatLongResponse.swift
//  WeatherApp
//
//  Created by rentamac on 30/01/2026.
//


import Foundation

// MARK: - WeatherRequest
struct LatLongResponse: Codable {
    let results: [Result]?
    let generationtimeMS: Double

    enum CodingKeys: String, CodingKey {
        case results
        case generationtimeMS = "generationtime_ms"
    }

    var hasResults: Bool {
        results != nil
    }
}


// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let latitude, longitude: Double
    let elevation: Double
    let featureCode, countryCode: String
    let admin1ID: Int
    let timezone: String
    let population: Int?
    let countryID: Int
    let country, admin1: String
    let admin2ID, admin3ID: Int?
    let admin2, admin3: String?

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, elevation
        case featureCode = "feature_code"
        case countryCode = "country_code"
        case admin1ID = "admin1_id"
        case timezone, population
        case countryID = "country_id"
        case country, admin1
        case admin2ID = "admin2_id"
        case admin3ID = "admin3_id"
        case admin2, admin3
    }
}

struct LatLongData {
    let response: LatLongResponse
    let name: String
    var hasResults: Bool { response.hasResults }
    var locName: String? { response.results?.first?.name }
    var locLatitude: Double? { response.results?.first?.latitude }
    var locLongitude: Double? { response.results?.first?.longitude }
}
