//
//  DetailsView.swift
//  WeatherApp
//
//  Created by rentamac on 23/01/2026.
//

import SwiftUI

struct DetailsView: View {
    //    @Binding var path: NavigationPath
    @StateObject var detailsViewModel: DetailsViewModel = DetailsViewModel()
    @EnvironmentObject var router: AppRouter
    var location: Location
    var body: some View {
        ZStack {
            Color("backgroundColor").ignoresSafeArea()
   
                VStack{
                    Spacer()
                    
                    if detailsViewModel.isLoading {
                        Text("Loading...")
                    } else {
                        Text("\(location.name)")
                            .font(.system(size: 50))
                            .foregroundStyle(.white)
                        Text("Precipitation Probablity:\(detailsViewModel.locationUpdated.precipitationProbablity)")
                            .font(.system(size: 18))
                            .foregroundStyle(.gray)
                        Image(systemName: location.weather.icon)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.yellow)
                        Text(detailsViewModel.locationUpdated.temperature)
                            .font(.title)
                            .bold()
                            .foregroundStyle(.white)
                        VStack {
                           
                            HStack(spacing: 12) {
                                
                                InfoCard( title: "UV Index", value: detailsViewModel.locationUpdated .uvIndex )
                                InfoCard( title: "Wind Speed", value: detailsViewModel.locationUpdated.windSpeed )
                                 }
                            .padding(.horizontal) .padding(.vertical, 10)
                            HStack(spacing: 12) {
                                InfoCard( title: "Rain", value: detailsViewModel.locationUpdated .rainSum )
                                InfoCard( title: "Humidity", value: detailsViewModel.locationUpdated.humidity )
                                 }
                            .padding(.horizontal) .padding(.vertical, 10)
                            HStack(spacing: 12) {
                                InfoCard( title: "Sunrise", value: detailsViewModel.locationUpdated .sunrise )
                                InfoCard( title: "Sunset", value: detailsViewModel.locationUpdated.sunset )
                                 }
                            .padding(.horizontal) .padding(.vertical, 10)

                        }

                        if detailsViewModel.errorMessage != nil {
                            Text("\(detailsViewModel.errorMessage!)")
                                .font(.title)
                                .foregroundStyle(.white)
                        }

                    }
                    

                }
            
            
        }
        .task {
            await detailsViewModel.loadWeather(location: location)
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
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
            ToolbarItem(placement: .principal) {
                Text("\(location.name)'s Weather")
                    .foregroundStyle(.white)
            }
            ToolbarItem(placement: .topBarTrailing) {
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

struct InfoCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack (alignment: .leading){
            Text(title)
                .font(.title2)
                .foregroundStyle(.gray)
                .bold()
                .multilineTextAlignment(.leading)
            Text(value)
                .font(.title)
                .bold()
                .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)

        .background(.gray.opacity(0.3))
        .cornerRadius(10)
    }
}

#Preview {
    DetailsView(
        location: Location(
            name: "Berlin",
            latitude: 52.52,
            longitude: 13.419998,
            weather: .foggy
        )
    )
}
