//
//  LandingView.swift
//  WeatherApp
//
//  Created by rentamac on 24/01/2026.
//

import SwiftUI

struct LandingView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {

        ZStack {
            Color("backgroundColor").ignoresSafeArea()
            VStack {
                Spacer()
                Image("weather-icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                Text("Breeze").foregroundStyle(Color.foreground)
                    .bold()
                    .font(.largeTitle)
                Text("Weather App by Rudraksh Chourey")
                    .foregroundStyle(Color("foregroundColor").opacity(0.7))
                Spacer()

                Button(action: {
                    router.navigate(to: .listLocationView)
                }) {
                    Image(systemName: "arrow.right")
                        .font(.title2)
                        .bold(true)
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(.blue))
                }
                Button(action: {
                    router.navigate(to: .developerView)
                }) {
                    Text("See Developer info")
                        .padding()
                        .foregroundStyle(.blue)
                }
            }
        }
        .onAppear {
           

            if let config = Bundle.main.object(forInfoDictionaryKey: "configuration") as? String {
                print("CONFIGURATION: \(config)")
            }
            
            if let baseURL = Bundle.main.object(forInfoDictionaryKey: "Baseurl") as? String {
                print("FromConVar: \(baseURL)")
            }
            
            if let baseURL = Bundle.main.object(forInfoDictionaryKey: "LatLongBaseurl") as? String {
                print("LatLongFromConVar: \(baseURL)")
            }
            
            if let basURLFromENV = ProcessInfo.processInfo.environment["API_BASE_URL"] {
                print("FromEnvVar: \(basURLFromENV)")
            }

        }
        
        
    }
}
