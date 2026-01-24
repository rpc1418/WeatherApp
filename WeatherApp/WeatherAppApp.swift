//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by rentamac on 22/01/2026.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject var router: AppRouter = AppRouter()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(router)
        }
    }
}


