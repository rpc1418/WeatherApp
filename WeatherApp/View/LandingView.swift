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
                Text("Breeze").foregroundStyle(.white)
                    .bold()
                    .font(.largeTitle)
                Text("Weather App by Rudraksh Chourey")
                    .foregroundStyle(.gray)
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
    }
}
