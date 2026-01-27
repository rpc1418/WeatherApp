
//
//  DetailsView.swift
//  WeatherApp
//
//  Created by rentamac on 23/01/2026.
//

import SwiftUI

struct DetailsView: View {
//    @Binding var path: NavigationPath
    @StateObject var detailsViewModel:DetailsViewModel = DetailsViewModel()
    @EnvironmentObject var router: AppRouter
    var location: Location
    var body: some View {
        ZStack{
            Color("backgroundColor").ignoresSafeArea()
            VStack
            {
                
                if(detailsViewModel.isLoading){
                    Text("Loading...")
                }else{
                    Text("\(location.name)")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    Image(systemName: location.weather.icon)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.yellow)
                    Text("\(detailsViewModel.temperature)")
                        .font(.title)
                        .foregroundStyle(.gray)
                    if detailsViewModel.errorMessage != nil {
                        Text("\(detailsViewModel.errorMessage!)")
                            .font(.title)
                            .foregroundStyle(.white)
                    }

                }
//                Text(location.temperature.temperatureText)
//                    .font(.title)
//                    .foregroundStyle(.blue)
                
//                Text("A warm breeze drifted through the streets as the afternoon sun hovered behind a veil of scattered clouds. In the north, the air felt dry and dusty, while the southern coast carried the familiar scent of moisture from the sea. Somewhere in the distance, dark monsoon clouds gathered slowly, hinting at an evening shower that would cool the earth and fill the air with the sound of rain tapping on rooftops.")
                
//                    .foregroundStyle(.white)
//                    .padding()

                    
                    
                   
            }
        }
        .task {
            await detailsViewModel.loadWeather(latitude: location.latitude, longitude: location.longitude)
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading){
                Button(action: {
//                                path.removeLast()
                    router.goBack()
                }) {
                    Image(systemName: "arrow.left")
                       .font(.title2)
                       .bold(true)
                       .foregroundStyle(.white)
                       .frame(width: 50, height: 50)
                }
              
            }
            ToolbarItem(placement: .principal){
                Text("\(location.name)'s Weather")
                    .foregroundStyle(.white)
            }
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
//                                path=NavigationPath()
                    router.goToHome()
                }) {
                    Image(systemName: "house")
                       .font(.title2)
                       .bold(true)
                       .foregroundStyle(.white)
                       .frame(width: 50, height: 50)
                }
              
            }
        }
        )
//        .onAppear {
//            print(" AppRouter available in Details view: \(String(describing: router))")
//        }
        .navigationBarBackButtonHidden()
    }
}
