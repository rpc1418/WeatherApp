//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by rentamac on 26/01/2026.
//
import Foundation

struct WeatherEndpoint: ApiEndpoint {
    
    
    let request: WeatherRequest
    
    var baseURL: String {
        guard let url = ProcessInfo.processInfo.environment["API_BASE_URL"],
              !url.isEmpty else {
            print("not available in env trying from config files")
            guard let plistURL = Bundle.main.object(forInfoDictionaryKey: "Baseurl") as? String,
                  !plistURL.isEmpty else {
                return "https://api.open-meteo.com"
            }
            print("From plist: \(plistURL)")
            return plistURL
        }
        return url
    }

    
    var path: String {
        "/v1/forecast"
    }
    
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "latitude", value: "\(request.latitude)"),
            URLQueryItem(name: "longitude", value: "\(request.longitude)"),
            URLQueryItem(name: "timezone", value: "Asia/Singapore"),
            URLQueryItem(name: "forecast_days", value: "1"),
            URLQueryItem(name: "daily", value: "temperature_2m_max,temperature_2m_min,uv_index_max,wind_speed_10m_max,rain_sum,relative_humidity_2m_mean,visibility_mean,precipitation_probability_mean,sunset,sunrise,weather_code")
        ]
    }

}

