//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by rentamac on 22/01/2026.
//

import SwiftUI
import Combine

class ListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var locations: [Location] = [
        Location(
            name: "Mumbai",
            weather:.sunny,
            temperature: Temperature(min: 22, max: 32)
        ),
        Location(
            name: "New Delhi",
            weather: .foggy,
            temperature: Temperature(min: 11, max: 24)
        ),
        Location(
            name: "Chennai",
            weather: .sunny,
            temperature: Temperature(min: 24, max: 36)
        ),
        Location(
            name: "Pune",
            weather: .sunny,
            temperature: Temperature(min: 22, max: 32)
        ),
        Location(
            name: "Bengaluru",
            weather: .rainy,
            temperature: Temperature(min: 24, max: 30)
        ),
        Location(
            name: "Gurgaon",
            weather: .foggy,
            temperature: Temperature(min: 11, max: 23)
        ),
        Location(
            name: "Noida",
            weather: .snow,
            temperature: Temperature(min: 9, max: 22)
        ),
        Location(
            name: "Hyderabad",
            weather: .windy,
            temperature: Temperature(min: 22, max: 32)
        ),
        Location(
            name: "Ahemedabad",
            weather: .sunny,
            temperature: Temperature(min: 20, max: 32)
        ),
        Location(
            name: "Indore",
            weather: .sunny,
            temperature: Temperature(min: 18, max: 24)
        )
    ]

    var filteredLocations: [Location] {
        if searchText.isEmpty {
            return locations
        }else {
            return  locations.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
       
    }
}
