//
//  ContentView.swift
//  WeatherApp
//
//  Created by rentamac on 22/01/2026.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var router: AppRouter
    var body: some View {
        NavigationStack(path: $router.path){
            LandingView()
                .navigationDestination(for: Route.self){
                    route in Group {switch route {
                    case .developerView: DeveloperInfoView()
                    case .listLocationView: ListView()
                    case .locationDetailView(let location): DetailsView(location: location)
                    }}
                }
        }
    }
}
#Preview {
    ContentView()
        .environmentObject(AppRouter())
}
