
//
//  DetailsView.swift
//  WeatherApp
//
//  Created by rentamac on 23/01/2026.
//

import SwiftUI

struct DetailsView: View {
    @Binding var path: NavigationPath
    var location: Location
    var body: some View {
        ZStack{
            Color("backgroundColor").ignoresSafeArea()
            VStack
            {
                Text("\(location.name)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                Image(systemName: location.weather.icon)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.yellow)
                Text(location.temperature.temperatureText)
                    .font(.title)
                    .foregroundStyle(.gray)
                
                Text("A warm breeze drifted through the streets as the afternoon sun hovered behind a veil of scattered clouds. In the north, the air felt dry and dusty, while the southern coast carried the familiar scent of moisture from the sea. Somewhere in the distance, dark monsoon clouds gathered slowly, hinting at an evening shower that would cool the earth and fill the air with the sound of rain tapping on rooftops.")
                    .foregroundStyle(.white)
                    .padding()
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarLeading){
                            Button(action: {
                                path.removeLast()
                            }) {
                                Text("Back")
                                    .foregroundStyle(.blue)
                                    .font(.title2)
                            }
                          
                        }
                        ToolbarItem(placement: .principal){
                            Text("Locations")
                                .foregroundStyle(.white)
                        }
                        ToolbarItem(placement: .topBarTrailing){
                            Button(action: {
                                path=NavigationPath()  
                            }) {
                                Text("Home")
                                    .foregroundStyle(.blue)
                                    .font(.title2)
                            }
                          
                        }
                    }
                    )
                    
                   
            }
        }
        .navigationBarBackButtonHidden()
    }
}
