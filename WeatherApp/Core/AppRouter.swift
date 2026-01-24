//
//  Route.swift
//  WeatherApp
//
//  Created by rentamac on 24/01/2026.
//
import SwiftUI
import Combine
//import Observation

enum Route: Hashable {
    case listLocationView
    case locationDetailView(location: Location)
    case developerView
}


class AppRouter: ObservableObject{
    @Published var path = NavigationPath()
    func navigate(to route: Route){
        path.append(route)
    }
    func goBack(){
        path.removeLast()
    }
    func goToHome(){
        path = NavigationPath()
    }
}
