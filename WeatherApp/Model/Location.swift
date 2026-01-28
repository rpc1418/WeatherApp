//
//  Location.swift
//  WeatherApp
//
//  Created by rentamac on 22/01/2026.
//

import SwiftUI
//enum Weather {
//    case sunny
//    case foggy
//    case snow
//    case rainy
//    case windy
//    
//    var icon: String {
//        switch self {
//        case .sunny:
//            return "sun.max.fill"
//        case .foggy:
//            return "cloud.fog.fill"
//        case .snow:
//            return "snowflake"
//        case .rainy:
//            return "cloud.rain.fill"
//        case .windy:
//            return "wind"
//        }
//    }
//}

//struct Temperature{
//    let min: Int
//    let max: Int
//    
//    var temperatureText: String {
//        "\(min)°C / \(max)°C"
//    }
//}
//
//struct Location: Identifiable, Hashable{
//    let id = UUID()
//    var name: String
//    let latitude: Double
//    let longitude: Double
//    var weather: Weather
//    var temperature: String = "--"
//    var uvIndex: String = "--"
//    var windSpeed: String = "--"
//    var rainSum: String = "--"
//    var humidity: String = "--"
//    var visibility: String = "--"
//    var precipitationProbablity: String = "--"
//    var sunset: String = "--"
//    var sunrise: String = "--"
//    
//    func hash(into hasher: inout Hasher) {
//            hasher.combine(id)
//            hasher.combine(name)
//        }
//    static func == (lhs: Location, rhs: Location) -> Bool {
//            lhs.id == rhs.id  
//        }
//}
