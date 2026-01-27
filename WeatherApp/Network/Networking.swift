//
//  Network.swift
//  WeatherApp
//
//  Created by rentamac on 26/01/2026.
//

import Foundation

protocol Networking {
    func request<T: Decodable>(
        endpoint: ApiEndpoint,
    responseType: T.Type,
    )async throws -> T
}
