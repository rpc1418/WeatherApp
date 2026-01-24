//
//  ContentView.swift
//  WeatherApp
//
//  Created by rentamac on 22/01/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {

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

                    NavigationLink(value: "NextScreen") {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                            .background(Circle().fill(.blue))
                    }
                    NavigationLink(value: "DeveloperInfo") {  // Use value: instead of destination
                        Text("See Developer info")
                            .padding()
                    }
                }
            }
            .navigationDestination(for: String.self) { value in  // Define destination here
                switch value {
                case "NextScreen":  ListView(path: $path)
                case "DeveloperInfo": DeveloperInfoView()
                default: EmptyView()
                }  // Pass path and value
            }
        }
        Text("number of view in stack:\(path.count)")
    }
}

#Preview {
    ContentView()
}
