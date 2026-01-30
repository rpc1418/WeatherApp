//
//  latLongApiEndpoit.swift
//  WeatherApp
//
//  Created by rentamac on 30/01/2026.
//

import Foundation


struct latLongApiEndpoint: ApiEndpoint {
    let request: LatLongRequest
    
    var baseURL: String {
        guard let url = ProcessInfo.processInfo.environment["LatLong_API_BASE_URL"],
              !url.isEmpty else {
            print("not available in env trying from config files")
            guard let plistURL = Bundle.main.object(forInfoDictionaryKey: "LatLongBaseurl") as? String,
                  !plistURL.isEmpty else {
                return "https://api.open-meteo.com"
            }
            print("From plist: \(plistURL)")
            return plistURL
        }
        return url
    }

    
    var path: String {
        "/v1/search"
    }
    
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "name", value: "\(request.name)")
        ]
    }
}
