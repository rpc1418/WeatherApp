//
//  LatLongService.swift
//  WeatherApp
//
//  Created by rentamac on 30/01/2026.
//

import Foundation

protocol LatLongServiceProtocol {
    func fetchLatLong(city: String) async throws -> LatLongData
}

final class LatLongService: LatLongServiceProtocol {
    private let networkService: Networking
    
    init(networkService: Networking) {
        self.networkService = networkService
    }
    
    func fetchLatLong(city: String) async throws -> LatLongData {
        let request = LatLongRequest(name: city)
        
        let endpoint = latLongApiEndpoint(request: request)
        
        let response: LatLongResponse = try await networkService.request(endpoint: endpoint, responseType: LatLongResponse.self)
//        print(city)
        return LatLongData(response: response,name: city)

    }
}
